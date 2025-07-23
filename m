Return-Path: <linux-pm+bounces-31318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2BB0EF47
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0857AAA22B5
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BE2798FF;
	Wed, 23 Jul 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GtBQbcau"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587642836B1;
	Wed, 23 Jul 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265091; cv=none; b=B02pJefQJnGc6di/rRy0HihtfGBcm8wAx9bgiC03Rdku2ESt/JLshL8iS/fsTODAfTo/TZbJLBpIR6MdKjXT+qh4zpH+/qfGoLBLxttZtr5hAbbyW4Xe9CS8B32lAdDZhJKZpSa73zwGXO1uwuChwXN1u6ZDUupsr79FwUd+UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265091; c=relaxed/simple;
	bh=G2qG9hHPZB8rSy4WLXD2llM8CtD+eMJdBoMWkNuf/tA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=aogf9PwVmp9p0NyzWFojWGtCI/eWKQsgEUwLxO4oupt1p3a26++MnWvZ+hQtCgTR7zlIoJ80mgJACl6SQwUiKjyO33UjM3Hbcmcr5KbiWjMMz9IncgWMIVrjfkfCVbgBEt2eqe5T8T1MpgVsSKsIaiKLA3PNNJDi3j5Xv9O1yG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GtBQbcau; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:To:From:
	Subject:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zpmQSAKkTebQQVtBM+I5jqudosBZ23Mrm7KNGcAFI7k=; b=GtBQbcauQxElSIfkYE17RKQoG6
	CsZS2WUF80iW6T0AbPHJsD6iLLH4UTpupU0RkQH2MgkXIbF0iAsfjI2l3htIbLnhT0J3QEHZTzpg4
	qqpbRdR9G580rIKifDwN4MxOUTsZN/IjF7CJiBMkXUBytQwvIyEdBlGAPptp1DVdpU04+77OvclS7
	Z/hRPD4YrWQP7xW6JbD3XJfRvCU5Xqx+d236KTKVu/m7kHVPBOkAy7ks/KCQQ0X2pllkCMG23xVVz
	deTXBAmP5fAgO/S4/e+PMCN8IPNgbqSbPpRKQBn9wL5kIcPxS7sRmE1tRcNOYuNiUtQNSlscDKlFk
	LS4hxWHQ==;
Received: from [54.239.6.190] (helo=edge-cache-169.e-lhr50.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueWL8-000000098Eb-139A;
	Wed, 23 Jul 2025 10:04:47 +0000
Message-ID: <c69938cffd4002a93a95a396affaa945e0f69206.camel@infradead.org>
Subject: Memory corruption after resume from hibernate with Arm GICv3 ITS
From: David Woodhouse <dwmw2@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
 <pavel@kernel.org>,  linux-pm <linux-pm@vger.kernel.org>, Marc Zyngier
 <maz@kernel.org>,  linux-arm-kernel@lists.infradead.org, "Saidi, Ali"
 <alisaidi@amazon.com>,  "oliver.upton" <oliver.upton@linux.dev>, Joey Gouly
 <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 "Heyne, Maximilian" <mheyne@amazon.de>,  Alexander Graf <graf@amazon.com>,
 "Stamatis, Ilias" <ilstam@amazon.com>
Date: Wed, 23 Jul 2025 12:04:44 +0200
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-CFNOq1sONN3HM3P5oRjg"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-CFNOq1sONN3HM3P5oRjg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We have seen guests crashing when, after they resume from hibernate,
the hypervisor serializes their state for live update or live
migration.

The Arm Generic Interrupt Controller is a complicated beast, and it
does scattershot DMA to little tables all across the guest's address
space, without even living behind an IOMMU.

Rather than simply turning it off overall, the guest has to explicitly
tear down *every* one of the individual tables which were previously
configured, in order to ensure that the memory is no longer used.

KVM's implementation of the virtual GIC only uses this guest memory
when asked to serialize its state. Instead of passing the information
up to userspace as most KVM devices will do for serialization, KVM
*only* supports scribbling it to guest memory.

So, when the transition from boot to resumed kernel leaves the vGIC
pointing at the *wrong* addresses, that's why a subsequent LU/LM of
that guest triggers the memory corruption by writing the KVM state to a
guest address that the now-running kernel did *not* expect.

I tried this, just to get some more information:

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -720,7 +720,7 @@ static struct its_collection *its_build_mapd_cmd(struct=
 its_node *its,
        its_encode_valid(cmd, desc->its_mapd_cmd.valid);
=20
        its_fixup_cmd(cmd);
-
+       printk("%s dev 0x%x valid %d addr 0x%lx\n", __func__, desc->its_map=
d_cmd.dev->device_id, desc->its_mapd_cmd.valid, itt_addr);
        return NULL;
 }
=20
@@ -4996,10 +4996,15 @@ static int its_save_disable(void)
        struct its_node *its;
        int err =3D 0;
=20
+       printk("%s\n", __func__);
        raw_spin_lock(&its_lock);
        list_for_each_entry(its, &its_nodes, entry) {
+               struct its_device *its_dev;
                void __iomem *base;
=20
+               list_for_each_entry(its_dev, &its->its_device_list, entry) =
{
+                       its_send_mapd(its_dev, 0);
+               }
                base =3D its->base;
                its->ctlr_save =3D readl_relaxed(base + GITS_CTLR);
                err =3D its_force_quiescent(base);
@@ -5032,8 +5037,10 @@ static void its_restore_enable(void)
        struct its_node *its;
        int ret;
=20
+       printk("%s\n", __func__);
        raw_spin_lock(&its_lock);
        list_for_each_entry(its, &its_nodes, entry) {
+               struct its_device *its_dev;
                void __iomem *base;
                int i;
=20
@@ -5083,6 +5090,10 @@ static void its_restore_enable(void)
                if (its->collections[smp_processor_id()].col_id <
                    GITS_TYPER_HCC(gic_read_typer(base + GITS_TYPER)))
                        its_cpu_init_collection(its);
+
+               list_for_each_entry(its_dev, &its->its_device_list, entry) =
{
+                       its_send_mapd(its_dev, 1);
+               }
        }
        raw_spin_unlock(&its_lock);
 }


Running on a suitable host with qemu, I reproduce with
  # echo reboot > /sys/power/disk
  # echo disk > /sys/power/state

Example qemu command line:
 qemu-system-aarch64  -serial mon:stdio -M virt,gic-version=3Dhost -cpu max=
 -enable-kvm -drive file=3D~/Fedora-Cloud-Base-Generic-42-1.1.aarch64.qcow2=
,id=3Dnvm,if=3Dnone,snapshot=3Doff,format=3Dqcow2 -device nvme,drive=3Dnvm,=
serial=3D1 -m 8g -nographic  -nic user,model=3Dvirtio -kernel vmlinuz-6.16.=
0-rc7-dirty  -initrd initramfs-6.16.0-rc7-dirty.img -append 'root=3DUUID=3D=
6c7b9058-d040-4047-a892-d2f1c7dee687 ro rootflags=3Dsubvol=3Droot no_timer_=
check console=3Dtty1 console=3DttyAMA0,115200n8 systemd.firstboot=3Doff roo=
tflags=3Dsubvol=3Droot no_console_suspend=3D1 resume_offset=3D366703 resume=
=3D/dev/nvme0n1p3' -trace gicv3_its\*

As the kernel boots up for the first time, it sends a normal MAPD command:

[    1.292956] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000

On hibernation, my newly added code unmaps and then *remaps* the same:

[root@localhost ~]# echo disk > /sys/power/state
[   42.118573] PM: hibernation: hibernation entry
[   42.134574] Filesystems sync: 0.015 seconds
[   42.134899] Freezing user space processes
[   42.135566] Freezing user space processes completed (elapsed 0.000 secon=
ds)
[   42.136040] OOM killer disabled.
[   42.136307] PM: hibernation: Preallocating image memory
[   42.371141] PM: hibernation: Allocated 297401 pages for snapshot
[   42.371163] PM: hibernation: Allocated 1189604 kbytes in 0.23 seconds (5=
172.19 MB/s)
[   42.371170] Freezing remaining freezable tasks
[   42.373465] Freezing remaining freezable tasks completed (elapsed 0.002 =
seconds)
[   42.378350] Disabling non-boot CPUs ...
[   42.378363] its_save_disable
[   42.378363] its_build_mapd_cmd dev 0x10 valid 0 addr 0x10f010000
[   42.378363] PM: hibernation: Creating image:
[   42.378363] PM: hibernation: Need to copy 153098 pages
[   42.378363] PM: hibernation: Image created (115354 pages copied, 37744 z=
ero pages)
[   42.378363] its_restore_enable
[   42.378363] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
[   42.383601] nvme nvme0: 1/0/0 default/read/poll queues
[   42.384411] nvme nvme0: Ignoring bogus Namespace Identifiers
[   42.384924] hibernate: Hibernating on CPU 0 [mpidr:0x0]
[   42.387742] PM: Using 1 thread(s) for lzo compression
[   42.387748] PM: Compressing and saving image data (115654 pages)...
[   42.387757] PM: Image saving progress:   0%
[   43.485794] PM: Image saving progress:  10%
[   44.739662] PM: Image saving progress:  20%
[   46.617453] PM: Image saving progress:  30%
[   48.437644] PM: Image saving progress:  40%
[   49.857855] PM: Image saving progress:  50%
[   52.156928] PM: Image saving progress:  60%
[   53.344810] PM: Image saving progress:  70%
[   54.472998] PM: Image saving progress:  80%
[   55.083950] PM: Image saving progress:  90%
[   56.406480] PM: Image saving progress: 100%
[   56.407088] PM: Image saving done
[   56.407100] PM: hibernation: Wrote 462616 kbytes in 14.01 seconds (33.02=
 MB/s)
[   56.407106] PM: Image size after compression: 148041 kbytes
[   56.408210] PM: S|
[   56.642393] Flash device refused suspend due to active operation (state =
20)
[   56.642871] Flash device refused suspend due to active operation (state =
20)
[   56.643432] reboot: Restarting system
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4f1]

Then the *boot* kernel comes up, does its own MAPD using a slightly differe=
nt address:

[    1.270652] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f009000

 ... and then transfers control to the hibernated kernel, which again
tries to unmap and remap the ITT at its original address due to my
suspend/resume hack (which is clearly hooking the wrong thing, but is
at least giving us useful information):

Starting systemd-hibernate-resume.service - Resume from hibernation...
[    1.391340] PM: hibernation: resume from hibernation
[    1.391861] random: crng reseeded on system resumption
[    1.391927] Freezing user space processes
[    1.392984] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[    1.393473] OOM killer disabled.
[    1.393486] Freezing remaining freezable tasks
[    1.395012] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[    1.400817] PM: Using 1 thread(s) for lzo decompression
[    1.400832] PM: Loading and decompressing image data (115654 pages)...
[    1.400836] hibernate: Hibernated on CPU 0 [mpidr:0x0]
[    1.438621] PM: Image loading progress:   0%
[    1.554623] PM: Image loading progress:  10%
[    1.594714] PM: Image loading progress:  20%
[    1.639317] PM: Image loading progress:  30%
[    1.683055] PM: Image loading progress:  40%
[    1.720726] PM: Image loading progress:  50%
[    1.768878] PM: Image loading progress:  60%
[    1.800203] PM: Image loading progress:  70%
[    1.822833] PM: Image loading progress:  80%
[    1.840985] PM: Image loading progress:  90%
[    1.871253] PM: Image loading progress: 100%
[    1.871611] PM: Image loading done
[    1.871617] PM: hibernation: Read 462616 kbytes in 0.47 seconds (984.28 =
MB/s)
[   42.378350] Disabling non-boot CPUs ...
[   42.378363] its_save_disable
[   42.378363] its_build_mapd_cmd dev 0x10 valid 0 addr 0x10f010000
[   42.378363] PM: hibernation: Creating image:
[   42.378363] PM: hibernation: Need to copy 153098 pages
[   42.378363] hibernate: Restored 0 MTE pages
[   42.378363] its_restore_enable
[   42.378363] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
[   42.417445] OOM killer enabled.
[   42.417455] Restarting tasks: Starting
[   42.419915] nvme nvme0: 1/0/0 default/read/poll queues
[   42.420407] Restarting tasks: Done
[   42.420781] PM: hibernation: hibernation exit
[   42.421149] nvme nvme0: Ignoring bogus Namespace Identifiers




--=-CFNOq1sONN3HM3P5oRjg
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcyMzEwMDQ0
NFowLwYJKoZIhvcNAQkEMSIEIJRcmGIMTMwLWVL6bKQMuTFIsyStkMHTcfyk47kgwNT6MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAhiJJWCIq4l4G
4x0xw4iPqhLigjUa7U83nxEiAGGClMi9uPNfB1Tg0oF1Sw58e0nwbppJHYlNf8SqZp9P9TrDX+x0
Y+cmK8dj7aNIxsmVdvoxWzONN8SdnVq7Ji780/Q0UdCseFS7ppQ3525v4WwlUQ48I4fkwQV+1A+v
k+tTxr3g4ROHz2OwBfrQLj+qzOCABvlBGZOvmajipZh2/U1lETmUWZJsTuFxQrA/bcDeEyK796ZC
t4y2N2uIjfSH2d7OQPMqcsWArYBgSpmx+gWpG+D1OCcn6x8C6gt9sA9MESHaG2PpK0X+PUeHuwsN
6Mh4JHyGFRWlJyNXd8uvrEPdHS0XTz/NH/JlBMS+WlKueg5mszXMwdTkIZRhAz7jdeLZ4PMDuIK5
LgIfwrBmZoa5+omaLF5ZzzRMnmVJoviNasBkBsqKG0UipwCm0bEWpvGRIw0/NUQs4f8soioAlJk7
HqUbx5tcxIukmVY7fOmod85pfO1XMxaRW3NcFiPxAqMwk+49gA7uUzmyLjyTLqSksCVsWk50QhVO
bTh5X3fW6JpqGqAagp9Mo4R6BR3hZkp2bALMJIoH10y6UG6TV0chrDg5NsitwZwKbr+5JSOyg9L8
uvxKCS3r92ToRjqtxA9Ao2iG8FA59EB5dLhnmoR8W4X+5egaB/r54J9owqBAaXIAAAAAAAA=


--=-CFNOq1sONN3HM3P5oRjg--

