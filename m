Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1F1951DD
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 08:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgC0H1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 03:27:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45359 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgC0H1Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 03:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585294044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eV/qAe+qkqLXHJwq0/oBSIudlDw3V3l9wrqYSL9XOT8=;
        b=CdJxkk4z6qHgyMiUGK7TXprqwLoZnUpCC+iKKh7xa6wkyQ/kIuYr3m8vfbmdgT243EFqrU
        RjrG/+JyEg6A46XuL7r6CsZaQ2a1+X0J5ORHmv8r6k2O9PHjf3+LEP9pxEjDfsfSmcga9v
        TVInvfqdOjp8+8gN0JnikkbsdVERkMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-nkrC-1WAN4Ke0EVEMVutTA-1; Fri, 27 Mar 2020 03:27:17 -0400
X-MC-Unique: nkrC-1WAN4Ke0EVEMVutTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D92800D50;
        Fri, 27 Mar 2020 07:27:16 +0000 (UTC)
Received: from olysonek-rh (unknown [10.40.192.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF995DA81;
        Fri, 27 Mar 2020 07:27:15 +0000 (UTC)
From:   olysonek@redhat.com (=?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?=)
To:     len.brown@intel.com, linux-pm@vger.kernel.org
Cc:     olysonek@redhat.com
Subject: x86_energy_perf_policy fails with Input/output error in a VM
Date:   Fri, 27 Mar 2020 08:27:12 +0100
Message-ID: <flspncygsvj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I've encountered an issue with x86_energy_perf_policy. If I run it on a
machine that I'm told is a qemu-kvm virtual machine running inside a
privileged container, I get the following error:

x86_energy_perf_policy: /dev/cpu/0/msr offset 0x1ad read failed: Input/outp=
ut error

I get the same error in a Digital Ocean droplet, so that might be a
similar environment.

I created the following patch which is intended to give a more
user-friendly message. It's based on a patch for turbostat from Prarit
Bhargava that was posted some time ago. The patch is "[v2] turbostat:
Running on virtual machine is not supported" [1].

Given my limited knowledge of the topic, I can't say with confidence
that this is the right solution, though (that's why this is not an
official patch submission). Also, I'm not sure what the convention with
exit codes is in this tool. Also, instead of the error message, perhaps
the tool should just not print anything in this case, which is how it
behaves in a "regular" VM?

[1] https://patchwork.kernel.org/patch/9868587/

Thanks.

Ond=C5=99ej Lyson=C4=9Bk

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.=
c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3fe1eed900d4..ff6c6661f075 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -622,6 +622,57 @@ void cmdline(int argc, char **argv)
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
+	char *flags, *hypervisor;
+	char *buffer;
+
+	/* On VMs /proc/cpuinfo contains a "flags" entry for hypervisor */
+	cpuinfo =3D fopen_or_die("/proc/cpuinfo", "ro");
+
+	buffer =3D malloc(4096);
+	if (!buffer) {
+		fclose(cpuinfo);
+		err(-ENOMEM, "buffer malloc fail");
+	}
+
+	if (!fread(buffer, 1024, 1, cpuinfo)) {
+		fclose(cpuinfo);
+		free(buffer);
+		err(1, "Reading /proc/cpuinfo failed");
+	}
+
+	flags =3D strstr(buffer, "flags");
+	rewind(cpuinfo);
+	fseek(cpuinfo, flags - buffer, SEEK_SET);
+	if (!fgets(buffer, 4096, cpuinfo)) {
+		fclose(cpuinfo);
+		free(buffer);
+		err(1, "Reading /proc/cpuinfo failed");
+	}
+	fclose(cpuinfo);
+
+	hypervisor =3D strstr(buffer, "hypervisor");
+
+	free(buffer);
+
+	if (hypervisor)
+		err(-1,
+		    "not supported on this virtual machine");
+}
=20
 int get_msr(int cpu, int offset, unsigned long long *msr)
 {
@@ -635,8 +686,10 @@ int get_msr(int cpu, int offset, unsigned long long *m=
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
@@ -1086,18 +1139,6 @@ int update_cpu_msrs(int cpu)
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

