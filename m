Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA25449924
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhKHQM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 11:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhKHQM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 11:12:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28498C061714;
        Mon,  8 Nov 2021 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:Date:Cc:To:
        From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=u5hAg7ueNiL/DD45rJcH/5UokM1RJiVl8kFo7aiuSxY=; b=0LOrYYnjJ/xTG8OVAGv6Aaeqj7
        Fw7pz0rYU5849HkPMOp/vhgZQSe1m4g7P3/QyR/hR1qZelsmqISBfrfggxr+JLk56y7FYoUa60scR
        PLTlupnop1Bj9WC1zjXlubIK3TrryBZw17R1pCtpOfRQDNTx8ECR6x2N0ME2uWWUFZdZxaigOLTXP
        mdVRnWIaOPLumM6QGj2bhyQrl4HpMNHp2pGtutcKL2Zc2iNSSJD0hJ9SWwUNN7mPwPL+284qY7wnv
        nUsoPNxrVbYOVfOOZ1fdaNZuaVREGrwMZ2DbE4MLgy80QYfBntrjPZSiWdaXvh84hjkLF3476ekC9
        5VNx/1Sg==;
Received: from [2001:8b0:10b:1::3ae] (helo=u3832b3a9db3152.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk7DM-00Guxd-83; Mon, 08 Nov 2021 16:09:44 +0000
Message-ID: <26decf155bffc021a97846c0a0ed09c2b5e0bef1.camel@infradead.org>
Subject: [PATCH] PM / hibernate: Allow ACPI hardware signature to be honoured
From:   David Woodhouse <dwmw2@infradead.org>
To:     linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     benh <benh@kernel.crashing.org>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        Amit Shah <aams@amazon.com>
Date:   Mon, 08 Nov 2021 16:09:41 +0000
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-6ZBoHAHfiP7kSxiwwsDM"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-6ZBoHAHfiP7kSxiwwsDM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Theoretically, when the hardware signature in FACS changes, the OS
is supposed to gracefully decline to attempt to resume from S4:

 "If the signature has changed, OSPM will not restore the system
  context and can boot from scratch"

In practice, Windows doesn't do this and many laptop vendors do allow
the signature to change especially when docking/undocking, so it would
be a bad idea to simply comply with the specification by default in the
general case.

However, there are use cases where we do want the compliant behaviour
and we know it's safe. Specifically, when resuming virtual machines where
we know the hypervisor has changed sufficiently that resume will fail.
We really want to be able to *tell* the guest kernel not to try, so it
boots cleanly and doesn't just crash. This patch provides a way to opt
in to the spec-compliant behaviour on the command line.

A follow-up patch may do this automatically for certain "known good"
machines based on a DMI match, or perhaps just for all hypervisor
guests since there's no good reason a hypervisor would change the
hardware_signature that it exposes to guests *unless* it wants them
to obey the ACPI specification.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++++++---
 arch/x86/kernel/acpi/sleep.c                  |  4 ++-
 drivers/acpi/sleep.c                          | 26 +++++++++++++++----
 include/linux/acpi.h                          |  2 +-
 include/linux/suspend.h                       |  1 +
 kernel/power/power.h                          |  1 +
 kernel/power/swap.c                           | 16 ++++++++++--
 7 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 43dc35fe5bc0..209402f4f11d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -225,14 +225,23 @@
 			For broken nForce2 BIOS resulting in XT-PIC timer.
=20
 	acpi_sleep=3D	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, nonvs, sci_force_enable, nobl }
+			Format: { s3_bios, s3_mode, s3_beep, s4_hwsig,
+				  s4_nohwsig, old_ordering, nonvs,
+				  sci_force_enable, nobl }
 			See Documentation/power/video.rst for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
+			s4_hwsig causes the kernel to check the ACPI hardware
+			signature during resume from hibernation, and gracefully
+			refuse to resume if it has changed. This complies with
+			the ACPI specification but not with reality, since
+			Windows does not do this and many laptops do change it
+			on docking. So the default behaviour is to allow resume
+			and simply warn when the signature changes, unless the
+			s4_hwsig option is enabled.
 			s4_nohwsig prevents ACPI hardware signature from being
-			used during resume from hibernation.
+			used (or even warned about) during resume.
 			old_ordering causes the ACPI 1.0 ordering of the _PTS
 			control method, with respect to putting devices into
 			low power states, to be enforced (the ACPI 2.0 ordering
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 3f85fcae450c..1e97f944b47d 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -139,8 +139,10 @@ static int __init acpi_sleep_setup(char *str)
 		if (strncmp(str, "s3_beep", 7) =3D=3D 0)
 			acpi_realmode_flags |=3D 4;
 #ifdef CONFIG_HIBERNATION
+		if (strncmp(str, "s4_hwsig", 8) =3D=3D 0)
+			acpi_check_s4_hw_signature(1);
 		if (strncmp(str, "s4_nohwsig", 10) =3D=3D 0)
-			acpi_no_s4_hw_signature();
+			acpi_check_s4_hw_signature(0);
 #endif
 		if (strncmp(str, "nonvs", 5) =3D=3D 0)
 			acpi_nvs_nosave();
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 3023224515ab..fa27319e5324 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -873,11 +873,11 @@ static inline void acpi_sleep_syscore_init(void) {}
 #ifdef CONFIG_HIBERNATION
 static unsigned long s4_hardware_signature;
 static struct acpi_table_facs *facs;
-static bool nosigcheck;
+static int sigcheck =3D -1; /* Default behaviour is just to warn */
=20
-void __init acpi_no_s4_hw_signature(void)
+void __init acpi_check_s4_hw_signature(int check)
 {
-	nosigcheck =3D true;
+	sigcheck =3D check;
 }
=20
 static int acpi_hibernation_begin(pm_message_t stage)
@@ -1005,12 +1005,28 @@ static void acpi_sleep_hibernate_setup(void)
 	hibernation_set_ops(old_suspend_ordering ?
 			&acpi_hibernation_ops_old : &acpi_hibernation_ops);
 	sleep_states[ACPI_STATE_S4] =3D 1;
-	if (nosigcheck)
+	if (!sigcheck)
 		return;
=20
 	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
-	if (facs)
+	if (facs) {
+		/*
+		 * s4_hardware_signature is the local variable which is just
+		 * used to warn about mismatch after we're attempting to
+		 * resume (in violation of the ACPI specification.)
+		 */
 		s4_hardware_signature =3D facs->hardware_signature;
+
+		if (sigcheck > 0) {
+			/*
+			 * If we're actually obeying the ACPI specification
+			 * then the signature is written out as part of the
+			 * swsusp header, in order to allow the boot kernel
+			 * to gracefully decline to resume.
+			 */
+			swsusp_hardware_signature =3D facs->hardware_signature;
+		}
+	}
 }
 #else /* !CONFIG_HIBERNATION */
 static inline void acpi_sleep_hibernate_setup(void) {}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 974d497a897d..5b6953189912 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -506,7 +506,7 @@ acpi_status acpi_release_memory(acpi_handle handle, str=
uct resource *res,
 int acpi_resources_are_enforced(void);
=20
 #ifdef CONFIG_HIBERNATION
-void __init acpi_no_s4_hw_signature(void);
+void __init acpi_check_s4_hw_signature(int check);
 #endif
=20
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e..5785d909c321 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -446,6 +446,7 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
=20
+extern u32 swsusp_hardware_signature;
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops=
);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 778bf431ec02..bb41a1a1c0d3 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -168,6 +168,7 @@ extern int swsusp_swap_in_use(void);
 #define SF_PLATFORM_MODE	1
 #define SF_NOCOMPRESS_MODE	2
 #define SF_CRC32_MODE	        4
+#define SF_HW_SIG		8
=20
 /* kernel/power/hibernate.c */
 extern int swsusp_check(void);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 3cb89baebc79..58e9641682e8 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -36,6 +36,8 @@
=20
 #define HIBERNATE_SIG	"S1SUSPEND"
=20
+u32 swsusp_hardware_signature;
+
 /*
  * When reading an {un,}compressed image, we may restore pages in place,
  * in which case some architectures need these pages cleaning before they
@@ -104,7 +106,8 @@ struct swap_map_handle {
=20
 struct swsusp_header {
 	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
-	              sizeof(u32)];
+	              sizeof(u32) - sizeof(u32)];
+	u32	hw_sig;
 	u32	crc32;
 	sector_t image;
 	unsigned int flags;	/* Flags to pass to the "boot" kernel */
@@ -312,7 +315,6 @@ static blk_status_t hib_wait_io(struct hib_bio_batch *h=
b)
 /*
  * Saving part
  */
-
 static int mark_swapfiles(struct swap_map_handle *handle, unsigned int fla=
gs)
 {
 	int error;
@@ -324,6 +326,10 @@ static int mark_swapfiles(struct swap_map_handle *hand=
le, unsigned int flags)
 		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
 		memcpy(swsusp_header->sig, HIBERNATE_SIG, 10);
 		swsusp_header->image =3D handle->first_sector;
+		if (swsusp_hardware_signature) {
+			swsusp_header->hw_sig =3D swsusp_hardware_signature;
+			flags |=3D SF_HW_SIG;
+		}
 		swsusp_header->flags =3D flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 =3D handle->crc32;
@@ -1542,6 +1548,12 @@ int swsusp_check(void)
 		} else {
 			error =3D -EINVAL;
 		}
+		if (!error && swsusp_header->flags & SF_HW_SIG &&
+		    swsusp_header->hw_sig !=3D swsusp_hardware_signature) {
+			pr_info("Suspend image hardware signature mismatch (%08x now %08x); abo=
rting resume.\n",
+				swsusp_header->hw_sig, swsusp_hardware_signature);
+			error =3D -EINVAL;
+		}
=20
 put:
 		if (error)
--=20
2.25.1


--=-6ZBoHAHfiP7kSxiwwsDM
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEx
MTA4MTYwOTQxWjAvBgkqhkiG9w0BCQQxIgQg5U5pmJj9IFM4VKCtqt/xJXFgbSVrpIpPUNbBqYsq
69Uwgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAAGi0Rwyhp4DRrs98xrr4n5dDRE5/25k+JBb0jgQrexYJLoksqWvgimEj1Uapyw4
5mJf7CSGctMLaIpxC9mFPQa1x9sAr+KrnSAR8zIL5Z1pad7OBd2BazUZ64OmtfeWCAR4FEvyfUnQ
6SLy1/PHIzQWjvUEABCW+cvtDOjQ2Pep4CPFE8WIULh9lyg9owQZnDgiHj8beau8r9rX/vAeBs/K
XjoP5bslbBhfdFr2GcDBHlLBa7Wc/KiVqsGiRwNJ/JMWCy55CFWaS1OEL8TfNrFsHbKIFn80B9Mn
xcMdOh6rb2rxCowJhe2g8yscZqJsTOmPIpBmZ6VqtnoVG4tanQQAAAAAAAA=


--=-6ZBoHAHfiP7kSxiwwsDM--

