Return-Path: <linux-pm+bounces-31380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69573B10BD9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7221CC7919
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5112D836E;
	Thu, 24 Jul 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vHciKMNP"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C5156F5E;
	Thu, 24 Jul 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364941; cv=none; b=rTeJat/hy3C7/CqANin0ZhoL2edVwuGsSfht9Jm3ukITcTqEOVYFirr0yndPbQigDNLqpALppmfVoPdbqPJqgudUtDRqT3XQG0bnc8gHmaE+jd4DCt/qDymOWN0ifR98Milc5UrrcNttaD22Gi2glhev9/odzXfLamuHu0DHAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364941; c=relaxed/simple;
	bh=eTOVdp47alwoXYVHcimD6BwRobPQabHs2fb2pcPjou0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ueHU67BQ6aQ9PyvNtZiWnuwtUMLJAUjAN8OUQ7n3USocFeD7WKFH/Nth8W5XItNzh7TUZzBoSWeyT1w9ew8K4fmIg589uyKfitb/SkDUYFBBeGilIY/MSj4FolQe/zAfbqUcZvL87xiPQDA+LRYhBYW+eeTuh1HWPKeUJI6Rzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vHciKMNP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CScUHBoe48sWcyDLzRr2WCLL+EBzj5RNclqT8OZiKFY=; b=vHciKMNPYPzyPcJdztunPDqz6I
	8DpoT8dbHwBO4EnJe+zjt8VwZR9tU1kxbHkx7zvw2J35z9YJJojlWioMkuRaP4noAgnfgVUdP6jZ6
	sZBzSGHlEXIpNF46lMkW6p5uKzmMaBK0qBlejIxQAyhQ6hWqDfiRajmVfOD6vXJjVCrSkxHOjzmud
	HXvVUB5epWZvDUp5Gh47oYncjia9/dGi6A4FtE2yvVWC/sciGzx44Y4e7VE8fSZ4Ql/DI+sJG8H5K
	C7O0IplfuyVhIMJpsx1m1BQy8UvQEZrgL7yfuP/uoHVmJ7SuvATVUXQ6iBPVvi+6PhdcRb7VQvznx
	UocO6NdA==;
Received: from [54.239.6.185] (helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uewJY-0000000Dw1c-1OUD;
	Thu, 24 Jul 2025 13:48:53 +0000
Message-ID: <aefe451c31d693cfe8f3cc157fd0009040fd48c7.camel@infradead.org>
Subject: Re: Memory corruption after resume from hibernate with Arm GICv3 ITS
From: David Woodhouse <dwmw2@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "Saidi, Ali" <alisaidi@amazon.com>,  "oliver.upton"
 <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Heyne, Maximilian"
 <mheyne@amazon.de>,  Alexander Graf <graf@amazon.com>, "Stamatis, Ilias"
 <ilstam@amazon.com>
Date: Thu, 24 Jul 2025 15:48:51 +0200
In-Reply-To: <CAJZ5v0iF7xAF105byp4j777Aks8KDKAh0-hJyfzkUFq5pm-JVQ@mail.gmail.com>
References: <c69938cffd4002a93a95a396affaa945e0f69206.camel@infradead.org>
	 <bc456c6b4b1ed51e568a37cf29b33d537e4bd94c.camel@infradead.org>
	 <CAJZ5v0iF7xAF105byp4j777Aks8KDKAh0-hJyfzkUFq5pm-JVQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-aFgVqWTbHqggURVS1l3H"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-aFgVqWTbHqggURVS1l3H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-07-24 at 11:51 +0200, Rafael J. Wysocki wrote:
>=20
> > So the hibernated kernel seems to be doing the right thing in both
> > suspend and resume phases but it looks like the *boot* kernel doesn't
> > call the suspend method before transitioning;
>=20
> No, it does this, but the messages are missing from the log.
>=20
> The last message you see from the boot/restore kernel is about loading
> the image; a lot of stuff happens afterwards.
>=20
> This message:
>=20
> [=C2=A0=C2=A0=C2=A0 1.871617] PM: hibernation: Read 462616 kbytes in 0.47=
 seconds (984.28 MB/s)
>=20
> is printed by load_compressed_image() which gets called by
> swsusp_read(), which is invoked by load_image_and_restore().
>=20
> It is successful, so hibernation_restore() gets called and it does
> quite a bit of work, including calling resume_target_kernel(), which
> among other things calls syscore_suspend(), from where your messages
> should be printed if I'm not mistaken.
>=20
> I have no idea why those messages don't get into the log (that would
> happen if your boot kernel were different from the image kernel and it
> didn't actually print them).

This is serial console output (stdout from 'qemu -serial mon:stdio'). I
guess the missing messages were in the printk buffer of the boot kernel
but just didn't get flushed? I added some --trace arguments to qemu to
see what's actually happening.

So when resuming, the boot looks like this:

gicv3_its_process_command GICv3 ITS: processing command at offset 0x4: 0x8
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10f0a20 V 1
gicv3_its_dte_write GICv3 ITS: Device Table write for DeviceID 0x10: valid =
1 size 0x6 ITTaddr 0x10f0a20
[   27.440351] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f0a2000

And then the transition goes:

[   47.668973] PM: Image loading progress:  90%
[   48.030462] PM: Image loading progress: 100%
[   48.031307] PM: Image loading done
[   48.031773] PM: hibernation: Read 460728 kbytes in 13.11 seconds (35.14 =
MB/s)
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10f0a20 V 0
gicv3_its_dte_write GICv3 ITS: Device Table write for DeviceID 0x10: valid =
0 size 0x6 ITTaddr 0x10f0a20
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10e3130 V 1
gicv3_its_dte_write GICv3 ITS: Device Table write for DeviceID 0x10: valid =
1 size 0x6 ITTaddr 0x10e3130
[  178.261284] Disabling non-boot CPUs ...
[  178.261674] its_save_disable
[  178.261674] its_build_mapd_cmd dev 0x10 valid 0 addr 0x10e313000
[  178.261674] PM: hibernation: Creating image:
[  178.261674] PM: hibernation: Need to copy 152532 pages
[  178.261674] hibernate: Restored 0 MTE pages
[  178.261674] its_restore_enable
[  178.261674] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10e313000
[  178.831481] OOM killer enabled.
[  178.831614] Restarting tasks: Starting

So we don't see the *printk* from the boot kernel, as you said. But it
*is* unmapping from the old address (MAPD, ITT_addr 0x10f0a20, Valid 0)
before the resumed kernel does the map at the address *it* was using
(MAPD, ITT_addr 0x10e3130, Valid 1). Looking just at the MAPD traces:

gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10e3130 V 1  =E2=86=90 Original clean boot
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10e3130 V 0  =E2=86=90 Prior to generating hibernate image
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10e3130 V 1  =E2=86=90 Before *writing* hibernate image and powering down=
 (actually reboot in this case)
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10f0a20 V 1  =E2=86=90 Boot kernel starting up prior to resume
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10f0a20 V 0  =E2=86=90 Boot kernel unmapping when we don't see its printk
gicv3_its_cmd_mapd GICv3 ITS: command MAPD DeviceID 0x10 Size 0x6 ITT_addr =
0x10e3130 V 1  =E2=86=90 Hibernated kernel remapping the ITT

So it looks like my test patch is doing the right thing, at least for
hibernation? I'm not sure about kexec?

There are also *other* tables where the GIC scribbles on memory, for
pending interrupts for KVM guests (vLPI pending tables). We've had
problems with those too=C2=B9, causing machines to crash on kexec because
the GIC scribbles on pages which are *actually* now the new kernel's
text. I'm not sure if we should try to come up with a unified solution
for that or deal with them separately... the solution there seems to
involve iterating =E2=88=80 kvm =E2=88=80 vCPU so I suspect it does need to=
 live in
KVM.

=C2=B9 https://lore.kernel.org/all/20250623132714.965474-2-dwmw2@infradead.=
org/

--=-aFgVqWTbHqggURVS1l3H
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcyNDEzNDg1
MVowLwYJKoZIhvcNAQkEMSIEIGdA8TLn5w0yM9m3hkArCF8ip/MthZYkUNAJRIFdZahOMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAwKcTjqyTylX4
8JU0heId4OrVxbhIKc/JaznYe+JOXl5Uhj94H3gkY567FqzDc/N5KlGIph4/OpOeE4zBffVjZdQj
3xX+hv8Qonmq4lvWtEThJKMGklkq4jXNCcgxrhUJD5Ddrnujq+uA68+zkUHIqz2GmbjlU7OeeVpZ
PJIr7rjjpJpBkfc7j51Ryb6ZTE/BlVm25kY18ChL5dxJxvcLfb6pwLWHgdyCyK8pkUVxz25O+9Ag
51DxmLcWzvyGY1qeGr6KjCiL1sV5ywsBDLZMNCRTjgq5QY+1oepsVqilsDDc2PHj17T7OMlDf38d
yOXOzx51UJpVALXkQEEOoAAxVmjqxXJY1Npf+ccv6MLPg1qG5us15oeZoM1Ao9HAP9gYY1BV7UZA
+mEXJY2MHOvzF/O5cvGrLbcNQIZtD05HO2RV/5f8GXUEyKhKJPcqN8dKnVvfpy4lroAysU9OH8z2
RJ3RL+cTGQNjGIQJ+0Qrljzw7EkGFViSjeVJ6Lo5tJnKJBWWF+IgN3yOfoxpIfqzp07QufSsPps2
DvtKR9jNQQv0/+huaTvVJVJI8pTPq2XiIav/y5WZOakF/xaYzxob9TFaul6Y43cjPZQW+nqj+lm3
8+g03iqhQXFRpkcLaC8ADFNAYKCE74+5uB4yly14l1IUliZiFUyic1QQJKGfx2YAAAAAAAA=


--=-aFgVqWTbHqggURVS1l3H--

