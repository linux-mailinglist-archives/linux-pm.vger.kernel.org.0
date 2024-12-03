Return-Path: <linux-pm+bounces-18444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF69E1C95
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D069B284D0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438C1E1C05;
	Tue,  3 Dec 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YkoaC8nD"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08661E1C17
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223002; cv=none; b=cirsTIr5DHGdr5Sja6B5O98DPH2CWIwfXjvhDqD7oZ4h4doeqsylMBom0nGtcJyPZdxdkrlQ6Rtbmb4vLn7HH9IbnRJ9L0SdW7hC+i/ccti7Ks8NbfeA9/Uk9QpN6GSAL7tJSPTjTXo1gCgrURUfIZmyFt8vhHaAalkMk4bI3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223002; c=relaxed/simple;
	bh=xCYxcFvc0d5EzsMXVghutFHnATGzOAF5i5rSRXENSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npk3Dzw6NiydgF1um87MgbumSkWZPVPn6Jv0p9hpyWJ5YDR9KtEaIRGMccEPFntq6L8ToOTEtAoEYt1qSUB6DLGhhZAUaybgoReypDck3zKZ4wZcJXO51Y7fRMf4RCwoOpOtfGSHUPDEPJN+N9UXsWrVYjN5ujBXOIr9IvP82pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YkoaC8nD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733222995;
	bh=xCYxcFvc0d5EzsMXVghutFHnATGzOAF5i5rSRXENSHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkoaC8nDmX6OcouFcQYTSATrSVr/R57eP8m+prosuR8sUuy12pCQCDGtkprFRK4EA
	 6ukRy+j3h2rMhlLpV2viovmlHrzjrFz8XYqOwJXGQ3kEpTpdBhgXSF1Q1iJYPwxYAu
	 G9KyuKUXH/ztt9tMLLnzQFATfy8KY0WVZnhc0J/I=
Date: Tue, 3 Dec 2024 11:49:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luca Coelho <luca@coelho.fi>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <32c9add1-4d59-4002-ab38-014b2cc3b709@t-8ch.de>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <7a84d900879c555dab675605ba925bc91b02510d.camel@coelho.fi>
 <82f1c285-ae2c-4a41-af10-016b52c149c1@t-8ch.de>
 <a093c1a6d740c7066f37805165f849eea4fd4860.camel@coelho.fi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a093c1a6d740c7066f37805165f849eea4fd4860.camel@coelho.fi>

On 2024-12-03 11:18:55+0200, Luca Coelho wrote:
> On Tue, 2024-12-03 at 09:25 +0100, Thomas Wei=C3=9Fschuh wrote:
> > On 2024-12-03 09:50:05+0200, Luca Coelho wrote:
> > > On Tue, 2024-12-03 at 07:50 +0100, Thomas Wei=C3=9Fschuh wrote:
> > > > (+Cc Sebastian)
> > > >=20
> > > > Hi Chaitanya,
> > > >=20
> > > > On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> > > > > Hope you are doing well. I am Chaitanya from the linux graphics t=
eam in Intel.
> > > > >=20
> > > > > This mail is regarding a regression we are seeing in our CI runs[=
1] on linux-next repository.
> > > >=20
> > > > Thanks for the report.
> > > >=20
> > > > > Since the version next-20241120 [2], we are seeing the following =
regression
> > > > >=20
> > > > > `````````````````````````````````````````````````````````````````=
````````````````
> > > > > <4>[=C2=A0=C2=A0 19.990743] Oops: general protection fault, proba=
bly for non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOP=
TI
> > > > > <4>[=C2=A0=C2=A0 19.990760] CPU: 21 UID: 110 PID: 867 Comm: prome=
theus-node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> > > > > <4>[=C2=A0=C2=A0 19.990771] Hardware name: Intel Corporation Arro=
w Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2=
410100007 10/10/2024
> > > > > <4>[=C2=A0=C2=A0 19.990782] RIP: 0010:power_supply_get_property+0=
x3e/0xe0
> > > > > `````````````````````````````````````````````````````````````````=
````````````````
> > > > > Details log can be found in [3].=20
> > > > >=20
> > > > > After bisecting the tree, the following patch [4] seems to be the=
 first "bad"
> > > > > commit
> > > > >=20
> > > > > `````````````````````````````````````````````````````````````````=
````````````````````````````````````````
> > > > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > > > > Author: =C2=A0 =C2=A0 Thomas Wei=C3=9Fschuh <mailto:linux@weisssc=
huh.net>
> > > > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > > > > Commit: =C2=A0 =C2=A0 Sebastian Reichel <mailto:sebastian.reichel=
@collabora.com>
> > > > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> > > > > =C2=A0 =C2=A0 power: supply: core: add wakeup source inhibit by p=
ower_supply_config=C2=A0 =C2=A0=C2=A0
> > > > > `````````````````````````````````````````````````````````````````=
````````````````````````````````````````
> > > > >=20
> > > > > This is now seen in our drm-tip runs as well. [5]
> > > > >=20
> > > > > Could you please check why the patch causes this regression and p=
rovide a fix if necessary?
> > > >=20
> > > > I don't see how this patch can lead to this error.
> > > > Could you doublecheck the bisect?
> > >=20
> > > FWIW I also bisected this and came to the same conclusion, this is the
> > > first bad commit.  My guess is that some component is not yet setting
> > > things up properly for the new feature.
> >=20
> > The thing is that at this point nothing is using this feature.
> > And the new code runs during registration while the error happens later.
> >=20
> > > This is very easily reproducible in our system, with vanila 6.13-rc1,
> > > so if there's anything you want to try, let us know.
> >=20
> > Can you try the following diffs, each alone on top of
> > 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2?
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index a2005e3c6f38..c6e7ca5b1283 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1411,7 +1411,7 @@ __power_supply_register(struct device *parent,
> >                 goto device_add_failed;
> >=20
> >         if (cfg && cfg->no_wakeup_source)
> > -               ws =3D false;
> > +               ;
> >=20
> >         rc =3D device_init_wakeup(dev, ws);
> >         if (rc)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index a2005e3c6f38..5aefba2ddcda 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1410,9 +1410,6 @@ __power_supply_register(struct device *parent,
> >         if (rc)
> >                 goto device_add_failed;
> >=20
> > -       if (cfg && cfg->no_wakeup_source)
> > -               ws =3D false;
> > -
> >         rc =3D device_init_wakeup(dev, ws);
> >         if (rc)
> >                 goto wakeup_init_failed;
> >=20
>=20
> I'll try this out now.
>=20
>=20
> > Could you also print the name of the device?
>=20
> This is a new Panther Lake machine, but we have reports of this
> happening on other platforms as well.  Which device exactly you want
> the info on?

I want the name of the in-kernel power supply device to figure
out which driver is used.
Sorry for the confusion.
The patch below prints this name.

> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index a2005e3c6f38..63e9e339cc01 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1356,6 +1356,8 @@ __power_supply_register(struct device *parent,
> >                 pr_warn("%s: Expected proper parent device for '%s'\n",
> >                         __func__, desc->name);
> >=20
> > +       pr_warn("PSY: name=3D%s\n", desc->name);
> > +
> >         psy =3D kzalloc(sizeof(*psy), GFP_KERNEL);
> >         if (!psy)
> >                 return ERR_PTR(-ENOMEM);
> >=20
> >=20
> > Also line numbers would be useful.
> > Is this configuration running KASAN?
>=20
> There's no KASAN, but I can add it if needed.

I think it would be useful, see below. (In addition to line numbers)

> Here's the full crash report I got yesterday, it's from our so-called
> drm-tip, which is basically v6.13-rc1 with DRM stuff on top:

This is a different trace than the others.
If that also bisects to the same commit that's a useful datapoint.
The register values look suspiciously like a poison value, so KASAN
would be useful.
It's not a poison value known to include/linux/poison.h, though.

> [   99.288768] display-ptlh-1 kernel: Oops: general protection fault, pro=
bably for non-canonical address 0xafafafafafafafaf: 0000 [#1] PREEMPT SMP N=
OPTI
> [   99.300294] display-ptlh-1 kernel: CPU: 3 UID: 0 PID: 10899 Comm: udev=
adm Not tainted 6.13.0-rc1-xe+ #13
> [   99.307849] display-ptlh-1 kernel: Hardware name: Intel Corporation Pa=
nther Lake Client Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.2454.D00.2=
411071130 11/07/2024
> [   99.320731] display-ptlh-1 kernel: RIP: 0010:string+0x4d/0xe0
> [   99.324541] display-ptlh-1 kernel: Code: ff 77 3c 45 89 d1 31 f6 49 01=
 f9 66 45 85 d2 75 19 eb 1e 49 39 f8 76 02 88 07 48 83 c7 01 83 c6 01 48 83=
 c2 01 4c 39 cf 74 07 <0f> b6 02 84 c0 75 e2 4c 89 c2 e8 f4 eb ff ff 5d c3 =
cc cc cc cc 48
> [   99.343456] display-ptlh-1 kernel: RSP: 0018:ffffc90012fcf930 EFLAGS: =
00010286
> [   99.348733] display-ptlh-1 kernel: RAX: afafafafafaf9faf RBX: ffffc900=
12fcf9a8 RCX: ffff0a00ffffff04
> [   99.355937] display-ptlh-1 kernel: RDX: afafafafafafafaf RSI: 00000000=
00000000 RDI: ffff888111829243
> [   99.363136] display-ptlh-1 kernel: RBP: ffffc90012fcf930 R08: ffff8881=
11829a1c R09: ffff888211829242
> [   99.370339] display-ptlh-1 kernel: R10: ffffffffffffffff R11: 00000000=
00000000 R12: ffff888111829a1c
> [   99.377542] display-ptlh-1 kernel: R13: ffffffff82f68964 R14: ffffffff=
82f68964 R15: ffff888111829243
> [   99.384743] display-ptlh-1 kernel: FS:  00007f973d83b8c0(0000) GS:ffff=
88844b980000(0000) knlGS:0000000000000000
> [   99.392904] display-ptlh-1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> [   99.398708] display-ptlh-1 kernel: CR2: 00005620a7387a18 CR3: 00000001=
2bec4006 CR4: 0000000000772ef0
> [   99.405913] display-ptlh-1 kernel: DR0: 0000000000000000 DR1: 00000000=
00000000 DR2: 0000000000000000
> [   99.413113] display-ptlh-1 kernel: DR3: 0000000000000000 DR6: 00000000=
ffff07f0 DR7: 0000000000000400
> [   99.420318] display-ptlh-1 kernel: PKRU: 55555554
> [   99.423062] display-ptlh-1 kernel: Call Trace:
> [   99.425543] display-ptlh-1 kernel:  <TASK>
> [   99.427675] display-ptlh-1 kernel:  ? show_regs+0x69/0x80
> [   99.431135] display-ptlh-1 kernel:  ? die_addr+0x38/0x90
> [   99.434488] display-ptlh-1 kernel:  ? exc_general_protection+0x1d4/0x4=
40
> [   99.439242] display-ptlh-1 kernel:  ? asm_exc_general_protection+0x27/=
0x30
> [   99.444186] display-ptlh-1 kernel:  ? string+0x4d/0xe0
> [   99.447367] display-ptlh-1 kernel:  vsnprintf+0x23e/0x560
> [   99.450815] display-ptlh-1 kernel:  add_uevent_var+0x96/0x190
> [   99.454610] display-ptlh-1 kernel:  ? string+0x5c/0xe0
> [   99.457790] display-ptlh-1 kernel:  power_supply_uevent+0x5a/0x200
> [   99.462025] display-ptlh-1 kernel:  dev_uevent+0x106/0x2e0
> [   99.465555] display-ptlh-1 kernel:  uevent_show+0xac/0x140
> [   99.469082] display-ptlh-1 kernel:  dev_attr_show+0x1a/0x60
> [   99.472701] display-ptlh-1 kernel:  sysfs_kf_seq_show+0xaa/0x140
> [   99.476758] display-ptlh-1 kernel:  kernfs_seq_show+0x3f/0x50
> [   99.480548] display-ptlh-1 kernel:  seq_read_iter+0x125/0x4e0
> [   99.484342] display-ptlh-1 kernel:  kernfs_fop_read_iter+0x170/0x200
> [   99.488748] display-ptlh-1 kernel:  vfs_read+0x260/0x350
> [   99.492106] display-ptlh-1 kernel:  ksys_read+0x70/0xf0
> [   99.495372] display-ptlh-1 kernel:  __x64_sys_read+0x19/0x20
> [   99.499076] display-ptlh-1 kernel:  x64_sys_call+0x1b85/0x2140
> [   99.502954] display-ptlh-1 kernel:  do_syscall_64+0x87/0x140
> [   99.506656] display-ptlh-1 kernel:  ? trace_irq_disable+0x6d/0xa0
> [   99.510799] display-ptlh-1 kernel:  ? trace_irq_enable+0x6d/0xa0
> [   99.514853] display-ptlh-1 kernel:  ? syscall_exit_to_user_mode+0xcc/0=
x200
> [   99.519779] display-ptlh-1 kernel:  ? do_syscall_64+0x93/0x140
> [   99.523659] display-ptlh-1 kernel:  ? __fput+0x1c6/0x2f0
> [   99.527014] display-ptlh-1 kernel:  ? trace_irq_disable+0x6d/0xa0
> [   99.531155] display-ptlh-1 kernel:  ? trace_irq_enable+0x6d/0xa0
> [   99.535211] display-ptlh-1 kernel:  ? syscall_exit_to_user_mode+0xcc/0=
x200
> [   99.540138] display-ptlh-1 kernel:  ? do_syscall_64+0x93/0x140
> [   99.544019] display-ptlh-1 kernel:  ? trace_irq_enable+0x6d/0xa0
> [   99.548078] display-ptlh-1 kernel:  ? syscall_exit_to_user_mode+0xcc/0=
x200
> [   99.553004] display-ptlh-1 kernel:  ? do_syscall_64+0x93/0x140
> [   99.556882] display-ptlh-1 kernel:  ? syscall_exit_to_user_mode+0xcc/0=
x200
> [   99.561809] display-ptlh-1 kernel:  ? do_syscall_64+0x93/0x140
> [   99.565691] display-ptlh-1 kernel:  entry_SYSCALL_64_after_hwframe+0x7=
6/0x7e
> [   99.570795] display-ptlh-1 kernel: RIP: 0033:0x7f973d71ba61
> [   99.574413] display-ptlh-1 kernel: Code: 00 48 8b 15 b9 73 0e 00 f7 d8=
 64 89 02 b8 ff ff ff ff eb bd e8 40 c4 01 00 f3 0f 1e fa 80 3d e5 f5 0e 00=
 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 =
89 e5 48 83 ec
> [   99.593325] display-ptlh-1 kernel: RSP: 002b:00007ffce625b508 EFLAGS: =
00000246 ORIG_RAX: 0000000000000000
> [   99.600962] display-ptlh-1 kernel: RAX: ffffffffffffffda RBX: 00000000=
00000003 RCX: 00007f973d71ba61
> [   99.608165] display-ptlh-1 kernel: RDX: 0000000000001008 RSI: 00005620=
a7386a70 RDI: 0000000000000003
> [   99.615366] display-ptlh-1 kernel: RBP: 00007ffce625b610 R08: 00007f97=
3d803b20 R09: 0000000000000000
> [   99.622571] display-ptlh-1 kernel: R10: 0000000000000001 R11: 00000000=
00000246 R12: 0000000000001008
> [   99.629774] display-ptlh-1 kernel: R13: ffffffffffffffff R14: 00000000=
00001008 R15: 00005620a7386a70
> [   99.636982] display-ptlh-1 kernel:  </TASK>
> [   99.639198] display-ptlh-1 kernel: Modules linked in: snd_sof_pci_inte=
l_ptl snd_sof_pci_intel_lnl snd_sof_pci_intel_mtl snd_sof_intel_hda_generic=
 snd_sof_pci snd_sof_xtensa_dsp snd_sof_intel_hda_common snd_soc_hdac_hda s=
nd_sof_intel_hda snd_sof snd_sof_utils snd_soc_acpi_intel_match snd_soc_acp=
i snd_soc_acpi_intel_sdca_quirks snd_intel_dspcfg snd_hda_codec snd_hwdep s=
nd_sof_intel_hda_mlink snd_hda_ext_core snd_hda_core snd_soc_sdca x86_pkg_t=
emp_thermal intel_powerclamp coretemp snd_soc_core snd_compress kvm_intel s=
nd_pcm kvm crct10dif_pclmul crc32_pclmul polyval_clmulni snd_seq polyval_ge=
neric ghash_clmulni_intel sha512_ssse3 sha256_ssse3 snd_seq_device snd_time=
r sha1_ssse3 cdc_ether snd aesni_intel usbnet wmi_bmof crypto_simd mii cryp=
td e1000e i2c_i801 soundcore i2c_smbus idma64 thunderbolt ucsi_acpi typec_u=
csi igen6_edac typec binfmt_misc video ov13b10 v4l2_fwnode v4l2_async video=
dev mc intel_skl_int3472_tps68470 wmi tps68470_regulator intel_pmc_core clk=
_tps68470 acpi_tad nls_iso8859_1 intel_vsec intel_skl_int3472_discrete pmt_=
telemetry
> [   99.639250] display-ptlh-1 kernel:  intel_skl_int3472_common acpi_pad =
pmt_class input_leds mac_hid sch_fq_codel msr parport_pc ppdev lp parport e=
fi_pstore drm nfnetlink ip_tables x_tables autofs4
> [   99.747167] display-ptlh-1 kernel: ---[ end trace 0000000000000000 ]---
> [   99.974871] display-ptlh-1 kernel: RIP: 0010:string+0x4d/0xe0
> [   99.978693] display-ptlh-1 kernel: Code: ff 77 3c 45 89 d1 31 f6 49 01=
 f9 66 45 85 d2 75 19 eb 1e 49 39 f8 76 02 88 07 48 83 c7 01 83 c6 01 48 83=
 c2 01 4c 39 cf 74 07 <0f> b6 02 84 c0 75 e2 4c 89 c2 e8 f4 eb ff ff 5d c3 =
cc cc cc cc 48
> [   99.997606] display-ptlh-1 kernel: RSP: 0018:ffffc90012fcf930 EFLAGS: =
00010286
> [  100.002891] display-ptlh-1 kernel: RAX: afafafafafaf9faf RBX: ffffc900=
12fcf9a8 RCX: ffff0a00ffffff04
> [  100.010099] display-ptlh-1 kernel: RDX: afafafafafafafaf RSI: 00000000=
00000000 RDI: ffff888111829243
> [  100.017302] display-ptlh-1 kernel: RBP: ffffc90012fcf930 R08: ffff8881=
11829a1c R09: ffff888211829242
> [  100.024502] display-ptlh-1 kernel: R10: ffffffffffffffff R11: 00000000=
00000000 R12: ffff888111829a1c
> [  100.031701] display-ptlh-1 kernel: R13: ffffffff82f68964 R14: ffffffff=
82f68964 R15: ffff888111829243
> [  100.038900] display-ptlh-1 kernel: FS:  00007f973d83b8c0(0000) GS:ffff=
88844b980000(0000) knlGS:0000000000000000
> [  100.047062] display-ptlh-1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> [  100.052866] display-ptlh-1 kernel: CR2: 00005620a7387a18 CR3: 00000001=
2bec4006 CR4: 0000000000772ef0
> [  100.060066] display-ptlh-1 kernel: DR0: 0000000000000000 DR1: 00000000=
00000000 DR2: 0000000000000000
> [  100.067265] display-ptlh-1 kernel: DR3: 0000000000000000 DR6: 00000000=
ffff07f0 DR7: 0000000000000400
> [  100.074473] display-ptlh-1 kernel: PKRU: 55555554
>=20
> --
> Cheers,
> Luca.
>=20

