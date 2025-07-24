Return-Path: <linux-pm+bounces-31364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF3B1073B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FB1AE0219
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A1255E27;
	Thu, 24 Jul 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spr/+tnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B9255240;
	Thu, 24 Jul 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350717; cv=none; b=jW9yaTiwXUWVrPv7H6e2+NfgkK98A0+nnjN3CVf4P6wPcd5bZ8+NR7nCTox/B7RBS0CPZOeU+Uc5uOmgyQa6KJRhj1IWU72Ym1NuZG5rjBnfxlSoZwau/o/9pSCNeLMq0a0KoTzVJb9v4fR/Bq4x9CfIaLBsaOzCNL/NMPEjQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350717; c=relaxed/simple;
	bh=JJe8KHsQAnu+gqVdwER/sMMdo6YDoZNcPOo+McX8d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmiTPKWFnoH4ntdeu7mMphAr9+N0qLX+7axX2DgYojlH3SRg6LuVoGqpqvZtMue0tkwatIzVmvEnnI+WKHI1EzmbdyutRZwdrWuGX/J8ksluGYRtur40E9tk6Zbw2sDd8CwgxWtA3c+fca/2aq22oxgKyayZJVOvj/BUlAL0Bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spr/+tnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2D8C4CEF8;
	Thu, 24 Jul 2025 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753350716;
	bh=JJe8KHsQAnu+gqVdwER/sMMdo6YDoZNcPOo+McX8d8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=spr/+tnSF0a+CeDxeJfG21KwMRxf8QNYNJLIVVGwZN6nR1g7XyVvc0m908tb79oU8
	 z02m+hiXOzEm/jrT4eHdL3cTR2/H1KGYJoCvAuYjHLwkj15ylhZdy05FH+2Vp3fUFh
	 727S5VD78AHN6cDHlQFMwZH7nsl4jAkxwYHTzxcxH4OJNSf5wwumICGNqoLP8QiLsn
	 KBgNvF16tFDGx/UEqw+Zhb0BODFcSQVOaAjo/B88DXCUqaePCXrNq2YnA2JoCFNhiy
	 EoqwG+gxLzkkYwQ/i5WUyOCc/SaHkWt4OQxCs1mxsJ4uLFhCRXMINCT1I6+GBmjIec
	 G8CQBmsCesSrQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-615913ff67fso479933eaf.0;
        Thu, 24 Jul 2025 02:51:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcFni6MdhWYvyy65njnNOSR2IwDtI+NsXkxF6wMC5lj/AalvfFZjYAUhgulSwLhYKlUlGi70tgRhU=@vger.kernel.org, AJvYcCVSLWIcDn4/ExU2tCdZd61H4AlBmfc6zeU+LH36uiExayiOh7NAXQi9HRXuYNJXohxDYTEddSsvsaL0rYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypwysJT/ibECTpkwdw/h67zVhXdqgxJzoUEdVdVCz+5pSfVZhW
	NHFspjMHV5FJksZg/ADvDG9sw/lwO3967Xlorhjb/oDW54OQbKe3IQLqnOh1sUIoND6JHVaJs7E
	5tM2v1NMgZVH1Q8TjHINmz0oSpYVYVak=
X-Google-Smtp-Source: AGHT+IGXZGemcHOaMknmg/vIr01gbXppnVlIe2EZaHDmt0zFa7IInSL12ytaASFNSxPE7uvNHvpcyGHxYIjLHxL/L/w=
X-Received: by 2002:a05:6820:6ae3:b0:613:90e1:729a with SMTP id
 006d021491bc7-618fe1959f3mr673415eaf.4.1753350715798; Thu, 24 Jul 2025
 02:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c69938cffd4002a93a95a396affaa945e0f69206.camel@infradead.org> <bc456c6b4b1ed51e568a37cf29b33d537e4bd94c.camel@infradead.org>
In-Reply-To: <bc456c6b4b1ed51e568a37cf29b33d537e4bd94c.camel@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 11:51:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iF7xAF105byp4j777Aks8KDKAh0-hJyfzkUFq5pm-JVQ@mail.gmail.com>
X-Gm-Features: Ac12FXwR9bMEVjkQxZtlOKnfFehKfKZhcvqVXqvBEZ65mSnP-S-ieJGH0Yqbk8g
Message-ID: <CAJZ5v0iF7xAF105byp4j777Aks8KDKAh0-hJyfzkUFq5pm-JVQ@mail.gmail.com>
Subject: Re: Memory corruption after resume from hibernate with Arm GICv3 ITS
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, "Saidi, Ali" <alisaidi@amazon.com>, 
	"oliver.upton" <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, "Heyne, Maximilian" <mheyne@amazon.de>, 
	Alexander Graf <graf@amazon.com>, "Stamatis, Ilias" <ilstam@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:26=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Wed, 2025-07-23 at 12:04 +0200, David Woodhouse wrote:
> > We have seen guests crashing when, after they resume from hibernate,
> > the hypervisor serializes their state for live update or live
> > migration.
> >
> > The Arm Generic Interrupt Controller is a complicated beast, and it
> > does scattershot DMA to little tables all across the guest's address
> > space, without even living behind an IOMMU.
> >
> > Rather than simply turning it off overall, the guest has to explicitly
> > tear down *every* one of the individual tables which were previously
> > configured, in order to ensure that the memory is no longer used.
> >
> > KVM's implementation of the virtual GIC only uses this guest memory
> > when asked to serialize its state. Instead of passing the information
> > up to userspace as most KVM devices will do for serialization, KVM
> > *only* supports scribbling it to guest memory.
> >
> > So, when the transition from boot to resumed kernel leaves the vGIC
> > pointing at the *wrong* addresses, that's why a subsequent LU/LM of
> > that guest triggers the memory corruption by writing the KVM state to a
> > guest address that the now-running kernel did *not* expect.
> >
> > I tried this, just to get some more information:
> >
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -720,7 +720,7 @@ static struct its_collection *its_build_mapd_cmd(st=
ruct its_node *its,
> >         its_encode_valid(cmd, desc->its_mapd_cmd.valid);
> >
> >         its_fixup_cmd(cmd);
> > -
> > +       printk("%s dev 0x%x valid %d addr 0x%lx\n", __func__, desc->its=
_mapd_cmd.dev->device_id, desc->its_mapd_cmd.valid, itt_addr);
> >         return NULL;
> >  }
> >
> > @@ -4996,10 +4996,15 @@ static int its_save_disable(void)
> >         struct its_node *its;
> >         int err =3D 0;
> >
> > +       printk("%s\n", __func__);
> >         raw_spin_lock(&its_lock);
> >         list_for_each_entry(its, &its_nodes, entry) {
> > +               struct its_device *its_dev;
> >                 void __iomem *base;
> >
> > +               list_for_each_entry(its_dev, &its->its_device_list, ent=
ry) {
> > +                       its_send_mapd(its_dev, 0);
> > +               }
> >                 base =3D its->base;
> >                 its->ctlr_save =3D readl_relaxed(base + GITS_CTLR);
> >                 err =3D its_force_quiescent(base);
> > @@ -5032,8 +5037,10 @@ static void its_restore_enable(void)
> >         struct its_node *its;
> >         int ret;
> >
> > +       printk("%s\n", __func__);
> >         raw_spin_lock(&its_lock);
> >         list_for_each_entry(its, &its_nodes, entry) {
> > +               struct its_device *its_dev;
> >                 void __iomem *base;
> >                 int i;
> >
> > @@ -5083,6 +5090,10 @@ static void its_restore_enable(void)
> >                 if (its->collections[smp_processor_id()].col_id <
> >                     GITS_TYPER_HCC(gic_read_typer(base + GITS_TYPER)))
> >                         its_cpu_init_collection(its);
> > +
> > +               list_for_each_entry(its_dev, &its->its_device_list, ent=
ry) {
> > +                       its_send_mapd(its_dev, 1);
> > +               }
> >         }
> >         raw_spin_unlock(&its_lock);
> >  }
> >
> >
> > Running on a suitable host with qemu, I reproduce with
> >   # echo reboot > /sys/power/disk
> >   # echo disk > /sys/power/state
> >
> > Example qemu command line:
> >  qemu-system-aarch64  -serial mon:stdio -M virt,gic-version=3Dhost -cpu=
 max -enable-kvm -drive file=3D~/Fedora-Cloud-Base-Generic-42-1.1.aarch64.q=
cow2,id=3Dnvm,if=3Dnone,snapshot=3Doff,format=3Dqcow2 -device nvme,drive=3D=
nvm,serial=3D1 -m 8g -nographic  -nic user,model=3Dvirtio -kernel vmlinuz-6=
.16.0-rc7-dirty  -initrd initramfs-6.16.0-rc7-dirty.img -append 'root=3DUUI=
D=3D6c7b9058-d040-4047-a892-d2f1c7dee687 ro rootflags=3Dsubvol=3Droot no_ti=
mer_check console=3Dtty1 console=3DttyAMA0,115200n8 systemd.firstboot=3Doff=
 rootflags=3Dsubvol=3Droot no_console_suspend=3D1 resume_offset=3D366703 re=
sume=3D/dev/nvme0n1p3' -trace gicv3_its\*
> >
> > As the kernel boots up for the first time, it sends a normal MAPD comma=
nd:
> >
> > [    1.292956] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
> >
> > On hibernation, my newly added code unmaps and then *remaps* the same:
> >
> > [root@localhost ~]# echo disk > /sys/power/state
> > [   42.118573] PM: hibernation: hibernation entry
> > [   42.134574] Filesystems sync: 0.015 seconds
> > [   42.134899] Freezing user space processes
> > [   42.135566] Freezing user space processes completed (elapsed 0.000 s=
econds)
> > [   42.136040] OOM killer disabled.
> > [   42.136307] PM: hibernation: Preallocating image memory
> > [   42.371141] PM: hibernation: Allocated 297401 pages for snapshot
> > [   42.371163] PM: hibernation: Allocated 1189604 kbytes in 0.23 second=
s (5172.19 MB/s)
> > [   42.371170] Freezing remaining freezable tasks
> > [   42.373465] Freezing remaining freezable tasks completed (elapsed 0.=
002 seconds)
> > [   42.378350] Disabling non-boot CPUs ...
> > [   42.378363] its_save_disable
> > [   42.378363] its_build_mapd_cmd dev 0x10 valid 0 addr 0x10f010000
> > [   42.378363] PM: hibernation: Creating image:
> > [   42.378363] PM: hibernation: Need to copy 153098 pages
> > [   42.378363] PM: hibernation: Image created (115354 pages copied, 377=
44 zero pages)
> > [   42.378363] its_restore_enable
> > [   42.378363] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
> > [   42.383601] nvme nvme0: 1/0/0 default/read/poll queues
> > [   42.384411] nvme nvme0: Ignoring bogus Namespace Identifiers
> > [   42.384924] hibernate: Hibernating on CPU 0 [mpidr:0x0]
> > [   42.387742] PM: Using 1 thread(s) for lzo compression
> > [   42.387748] PM: Compressing and saving image data (115654 pages)...
> > [   42.387757] PM: Image saving progress:   0%
> > [   43.485794] PM: Image saving progress:  10%
> > [   44.739662] PM: Image saving progress:  20%
> > [   46.617453] PM: Image saving progress:  30%
> > [   48.437644] PM: Image saving progress:  40%
> > [   49.857855] PM: Image saving progress:  50%
> > [   52.156928] PM: Image saving progress:  60%
> > [   53.344810] PM: Image saving progress:  70%
> > [   54.472998] PM: Image saving progress:  80%
> > [   55.083950] PM: Image saving progress:  90%
> > [   56.406480] PM: Image saving progress: 100%
> > [   56.407088] PM: Image saving done
> > [   56.407100] PM: hibernation: Wrote 462616 kbytes in 14.01 seconds (3=
3.02 MB/s)
> > [   56.407106] PM: Image size after compression: 148041 kbytes
> > [   56.408210] PM: S|
> > [   56.642393] Flash device refused suspend due to active operation (st=
ate 20)
> > [   56.642871] Flash device refused suspend due to active operation (st=
ate 20)
> > [   56.643432] reboot: Restarting system
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4f1]
> >
> > Then the *boot* kernel comes up, does its own MAPD using a slightly dif=
ferent address:
> >
> > [    1.270652] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f009000
> >
> >  ... and then transfers control to the hibernated kernel, which again
> > tries to unmap and remap the ITT at its original address due to my
> > suspend/resume hack (which is clearly hooking the wrong thing, but is
> > at least giving us useful information):
> >
> > Starting systemd-hibernate-resume.service - Resume from hibernation...
> > [    1.391340] PM: hibernation: resume from hibernation
> > [    1.391861] random: crng reseeded on system resumption
> > [    1.391927] Freezing user space processes
> > [    1.392984] Freezing user space processes completed (elapsed 0.001 s=
econds)
> > [    1.393473] OOM killer disabled.
> > [    1.393486] Freezing remaining freezable tasks
> > [    1.395012] Freezing remaining freezable tasks completed (elapsed 0.=
001 seconds)
> > [    1.400817] PM: Using 1 thread(s) for lzo decompression
> > [    1.400832] PM: Loading and decompressing image data (115654 pages).=
..
> > [    1.400836] hibernate: Hibernated on CPU 0 [mpidr:0x0]
> > [    1.438621] PM: Image loading progress:   0%
> > [    1.554623] PM: Image loading progress:  10%
> > [    1.594714] PM: Image loading progress:  20%
> > [    1.639317] PM: Image loading progress:  30%
> > [    1.683055] PM: Image loading progress:  40%
> > [    1.720726] PM: Image loading progress:  50%
> > [    1.768878] PM: Image loading progress:  60%
> > [    1.800203] PM: Image loading progress:  70%
> > [    1.822833] PM: Image loading progress:  80%
> > [    1.840985] PM: Image loading progress:  90%
> > [    1.871253] PM: Image loading progress: 100%
> > [    1.871611] PM: Image loading done
> > [    1.871617] PM: hibernation: Read 462616 kbytes in 0.47 seconds (984=
.28 MB/s)
> > [   42.378350] Disabling non-boot CPUs ...
> > [   42.378363] its_save_disable
> > [   42.378363] its_build_mapd_cmd dev 0x10 valid 0 addr 0x10f010000
> > [   42.378363] PM: hibernation: Creating image:
> > [   42.378363] PM: hibernation: Need to copy 153098 pages
> > [   42.378363] hibernate: Restored 0 MTE pages
> > [   42.378363] its_restore_enable
> > [   42.378363] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
> > [   42.417445] OOM killer enabled.
> > [   42.417455] Restarting tasks: Starting
> > [   42.419915] nvme nvme0: 1/0/0 default/read/poll queues
> > [   42.420407] Restarting tasks: Done
> > [   42.420781] PM: hibernation: hibernation exit
> > [   42.421149] nvme nvme0: Ignoring bogus Namespace Identifiers
>
> Rafael points out that the resumed kernel isn't doing the unmap/remap
> again; it's merely printing the *same* messages again from the printk
> buffer.
>
> Before writing the hibernate image, the kernel calls the suspend op:
>
> [   42.378350] Disabling non-boot CPUs ...
> [   42.378363] its_save_disable
> [   42.378363] its_build_mapd_cmd dev 0x10 valid 0 addr 0x10f010000
> [   42.378363] PM: hibernation: Creating image:
>
> Those messages are stored in the printk buffer in the image. Then the
> hibernating kernel calls the resume op, and writes the image:
>
> [   42.378363] PM: hibernation: Image created (115354 pages copied, 37744=
 zero pages)
> [   42.378363] its_restore_enable
> [   42.378363] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
> [   42.383601] nvme nvme0: 1/0/0 default/read/poll queues
> [   42.384411] nvme nvme0: Ignoring bogus Namespace Identifiers
> [   42.384924] hibernate: Hibernating on CPU 0 [mpidr:0x0]
> [   42.387742] PM: Using 1 thread(s) for lzo compression
> [   42.387748] PM: Compressing and saving image data (115654 pages)...
> [   42.387757] PM: Image saving progress:   0%
> [   43.485794] PM: Image saving progress:  10%
> ...
>
> Then the boot kernel comes up and maps an ITT:
>
> [    1.270652] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f009000
>
> The boot kernel never seems to *unmap* that because the suspend method
> doesn't get called before resuming the image.
>
> On resume, the previous kernel flushes the messages which were in its
> printk buffer to the serial port again, and then prints these *new*
> messages...
>
> [   42.378363] hibernate: Restored 0 MTE pages
> [   42.378363] its_restore_enable
> [   42.378363] its_build_mapd_cmd dev 0x10 valid 1 addr 0x10f010000
> [   42.417445] OOM killer enabled.
> [   42.417455] Restarting tasks: Starting
>
> So the hibernated kernel seems to be doing the right thing in both
> suspend and resume phases but it looks like the *boot* kernel doesn't
> call the suspend method before transitioning;

No, it does this, but the messages are missing from the log.

The last message you see from the boot/restore kernel is about loading
the image; a lot of stuff happens afterwards.

This message:

[    1.871617] PM: hibernation: Read 462616 kbytes in 0.47 seconds (984.28 =
MB/s)

is printed by load_compressed_image() which gets called by
swsusp_read(), which is invoked by load_image_and_restore().

It is successful, so hibernation_restore() gets called and it does
quite a bit of work, including calling resume_target_kernel(), which
among other things calls syscore_suspend(), from where your messages
should be printed if I'm not mistaken.

I have no idea why those messages don't get into the log (that would
happen if your boot kernel were different from the image kernel and it
didn't actually print them).

> is that intentional? I think we *should* unmap all the ITTs from the boot=
 kernel.

Yes, it's better to unmap them, even though ->

> At least for the vGIC, when the hibernated image resumes it will
> *change* the mapping for every device that it knows about, but there's
> a *possibility* that the boot kernel might have set up one that the
> hibernated kernel didn't know about (if a new PCI device exists now?).

-> HW configuration is not supposed to change across hibernation/restore.

> And I'm not sure what the real hardware will do if it gets a subsequent
> MAPD without the previous one being unmapped.

