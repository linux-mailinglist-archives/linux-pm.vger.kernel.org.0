Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33319B373
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgDAQvp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 12:51:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388689AbgDAQvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 12:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585759903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98Kbqh9WAyrL+bK6FJQbi+5GjOxMjtcuiYBQroEuNIc=;
        b=H4SxZnw8gzADcU20ZYvcsxVdSmZLeh1ttrWRwkXwBje1VtXSdtIsiWjGz98q1XaeBNpezb
        xquBwKsXlYPMtEm64ESF7v7mDRnCGUYEkbTHcsjG6hrvp663umoVrEpbw1u5FArvwFpVoe
        4iWUIlZECAjXJlPSUAno+LZm7HSR6GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-cHEkOTjsOe2jp_CMXZAbOQ-1; Wed, 01 Apr 2020 12:51:40 -0400
X-MC-Unique: cHEkOTjsOe2jp_CMXZAbOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9C8DB61;
        Wed,  1 Apr 2020 16:51:39 +0000 (UTC)
Received: from olysonek-rh (unknown [10.40.195.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B8E496B93;
        Wed,  1 Apr 2020 16:51:38 +0000 (UTC)
From:   =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>
To:     "Brown\, Len" <len.brown@intel.com>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: x86_energy_perf_policy fails with Input/output error in a VM
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94881B93DF1@fmsmsx101.amr.corp.intel.com>
References: <flspncygsvj.fsf@redhat.com> <1A7043D5F58CCB44A599DFD55ED4C94881B93DF1@fmsmsx101.amr.corp.intel.com>
Date:   Wed, 01 Apr 2020 18:51:36 +0200
Message-ID: <flseet7f8tj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

"Brown, Len" <len.brown@intel.com> writes:

> Thanks for the note,
>
> I agree that is unfriendly how the tool tells the user that it is not pos=
sible for it to run in a VM guest.
> If people are running into that, and we can make it more graceful, we sho=
uld.

My use case is being able to differentiate why x86_energy_perf_policy
failed in programs that use it, namely Tuned [1].

>
> Is parsing /proc/cpuinfo a universal/reliable way to detect this situatio=
n?

From what I've read it seems that it's possible to create a VM that does
not have 'hypervisor' in CPU flags. However I don't think this is a
problem for us - false negatives in the detection will just preserve the
current behaviour.

Regarding the reverse case, to get the 'hypervisor' CPU flag on bare
metal, you'd have to change the CPU microcode so that the CPUID
instruction returns different values, as far as I understand it.

Also, the kernel uses the 'hypervisor' flag (X86_FEATURE_HYPERVISOR)
internally in a number of places to detect a virtual machine. E.g.
arch/x86/events/core.c:270 or drivers/acpi/processor_idle.c:509 as of
commit 9420e8ade4353a6710.

However, perhaps it would be good to change the patch so that it prints
the original msr reading error in cases where /proc/cpuinfo is unavailable.

I've fixed up the patch a bit and changed it so that it searches only
for whole words '\<hypervisor\>' on lines beginning with
'flags\t\t'. This should make it more reliable.

Consider the patch
Signed-off-by: Ond=C5=99ej Lyson=C4=9Bk <olysonek@redhat.com>

[1] https://github.com/redhat-performance/tuned/blob/master/tuned/plugins/p=
lugin_cpu.py#L96

Ondrej Lysonek


diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.=
c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3fe1eed900d4..29e0afbb7b4f 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -622,6 +622,77 @@ void cmdline(int argc, char **argv)
 	}
 }
=20
+/*
+ * Open a file, and exit on failure
+ */
+FILE *fopen_or_die(const char *path, const char *mode)
+{
+	FILE *filep =3D fopen(path, "r");
+
+	if (!filep)
+		err(1, "%s: open failed", path);
+	return filep;
+}
+
+void err_on_hypervisor(void)
+{
+	FILE *cpuinfo;
+	char *buffer;
+	char *flags;
+	char *start_pos, *stop_pos;
+	const char *err_msg =3D NULL;
+	const char *hypervisor =3D " hypervisor";
+
+	/* On VMs, /proc/cpuinfo contains a "hypervisor" flags entry */
+	cpuinfo =3D fopen_or_die("/proc/cpuinfo", "ro");
+
+	buffer =3D malloc(4096);
+	if (!buffer) {
+		err_msg =3D "buffer malloc failed";
+		goto close_file;
+	}
+
+	if (!fread(buffer, 1024, 1, cpuinfo)) {
+		err_msg =3D "Reading /proc/cpuinfo failed";
+		goto free_mem;
+	}
+
+	flags =3D strstr(buffer, "flags\t\t");
+	if (!flags || (flags > buffer && *(flags - 1) !=3D '\n'))
+		goto free_mem;
+
+	if (fseek(cpuinfo, flags - buffer, SEEK_SET)) {
+		err_msg =3D "fseek on /proc/cpuinfo failed";
+		goto free_mem;
+	}
+	if (!fgets(buffer, 4096, cpuinfo)) {
+		err_msg =3D "Reading /proc/cpuinfo failed";
+		goto free_mem;
+	}
+
+	start_pos =3D buffer;
+	while (1) {
+		start_pos =3D strstr(start_pos, hypervisor);
+		stop_pos =3D start_pos + strlen(hypervisor);
+		if (!start_pos || (*stop_pos =3D=3D ' ' ||
+				   *stop_pos =3D=3D '\n' ||
+				   *stop_pos =3D=3D '\0'))
+			break;
+		start_pos =3D stop_pos;
+	}
+
+	if (start_pos) {
+		err_msg =3D "not supported on this virtual machine";
+	}
+
+free_mem:
+	free(buffer);
+close_file:
+	fclose(cpuinfo);
+
+	if (err_msg)
+		err(1, err_msg);
+}
=20
 int get_msr(int cpu, int offset, unsigned long long *msr)
 {
@@ -635,8 +706,10 @@ int get_msr(int cpu, int offset, unsigned long long *m=
sr)
 		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as=
 root", pathname);
=20
 	retval =3D pread(fd, msr, sizeof(*msr), offset);
-	if (retval !=3D sizeof(*msr))
+	if (retval !=3D sizeof(*msr)) {
+		err_on_hypervisor();
 		err(-1, "%s offset 0x%llx read failed", pathname, (unsigned long long)of=
fset);
+	}
=20
 	if (debug > 1)
 		fprintf(stderr, "get_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, *msr);
@@ -1086,18 +1159,6 @@ int update_cpu_msrs(int cpu)
 	return 0;
 }
=20
-/*
- * Open a file, and exit on failure
- */
-FILE *fopen_or_die(const char *path, const char *mode)
-{
-	FILE *filep =3D fopen(path, "r");
-
-	if (!filep)
-		err(1, "%s: open failed", path);
-	return filep;
-}
-
 unsigned int get_pkg_num(int cpu)
 {
 	FILE *fp;
--=20

