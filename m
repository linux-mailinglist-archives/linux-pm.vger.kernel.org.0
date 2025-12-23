Return-Path: <linux-pm+bounces-39901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B935ECDAAAA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 22:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A9BD302083B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79730DED8;
	Tue, 23 Dec 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iwtqE6lq"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF42FABE1;
	Tue, 23 Dec 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766524157; cv=pass; b=LFwKAkSkggHz8EgCcf0DXRkE+0JPOmFBrmLzlNAvTBG04KBLUmUoPQWppz2bc9GJwhfk3IsDp8iw53+W/VgfKPp1vzphn1xQ27OmmdqHFTJA2bskYv/iA1DOR4f4k8l8g8H0fHKGHUkmOxEGtG1pD6/XPP7vpAGX0Lpbv0cGZvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766524157; c=relaxed/simple;
	bh=VXWNJbjeW+XfWfdP+JpgsxNRHGEP7GNhC0twpJ1rQp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjhCrwU5NoTiiilmnnv96PfmKB0GNOlTSOD0GM4ZDOeuMys0sXo9ltnmNTRNkrCK+bwruVpbsRtQN6oUeRP/K3B//Hgg6E917FvPFJlr5JhqXOy9iY/5+QgkeBiBIsyKaE5IgrIynIkzpxom38NZkPVvuX8DQWVtNRq5atggMhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iwtqE6lq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766524141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ep2yqpwPQgA6IwrCtoFQ2hC0GxvjsB9L5JOziCiJYLxsnrkiVWOtUoeni1Wn2uvDlIjasrq+7PIUM1k8UF903fzcyWgwnrUXgcMQZIswAItAvdfC9wkKw1zc+0iLU+dCAe+boGIM878J8Bf8H+BSd5ALool6tIIxrku9SkEA8Mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766524141; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s8NAUT9bQs7qbFSasLydr/oelzy5DvyIfqkHKjJGVGI=; 
	b=Ne3L1koMO7S1Hp8R07idwRkW03ZzUxDyMnSb5k0RvqIJei4NiREZmWNZPGvTXdr7JVz0JdNlCWK3yKEAInP0351bnBaU2y+MDXhkVjccaYLB4C/HiagOMWP2IAWp1nKCRtstBmMSpkd8WsvFt1VueoEk5uqprrATNjft3rXhZqM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766524141;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=s8NAUT9bQs7qbFSasLydr/oelzy5DvyIfqkHKjJGVGI=;
	b=iwtqE6lq4CdFM+EPyvIlThYfrkEAr+jJapENLUeODZR+czZs6+rlcD6tyya2Rh8n
	qrNSgLhPcmk02RWyF+WLrJY5FcQ2GxYuaItEwWJGfAMVMDI18mQeGWth3iwFeLvLsvI
	SZV6obOXl/vp1HmofsZqqmdiHOhCEsTLiFKH8xFc=
Received: by mx.zohomail.com with SMTPS id 1766524138042730.0153141909041;
	Tue, 23 Dec 2025 13:08:58 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id E3BEE18197C; Tue, 23 Dec 2025 22:08:54 +0100 (CET)
Date: Tue, 23 Dec 2025 22:08:54 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Riwen Lu <luriwen@kylinos.cn>, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xiongxin <xiongxin@kylinos.cn>, 
	regressions@lists.linux.dev
Subject: [REGRESSION] Re: [PATCH v3] PM: suspend: Make pm_test delay
 interruptible by wakeup events
Message-ID: <aUsAk0k1N9hw8IkY@venus>
References: <20251113012638.1362013-1-luriwen@kylinos.cn>
 <CAJZ5v0hwhVO6J2nS2-byU0+Lm8QbzdBzv4-X4eLNNUpTg+41Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lymdjenuo2frg5f"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hwhVO6J2nS2-byU0+Lm8QbzdBzv4-X4eLNNUpTg+41Kg@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/266.517.63
X-ZohoMailClient: External


--6lymdjenuo2frg5f
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION] Re: [PATCH v3] PM: suspend: Make pm_test delay
 interruptible by wakeup events
MIME-Version: 1.0

Hi,

On Fri, Nov 14, 2025 at 05:11:16PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 13, 2025 at 2:26=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wro=
te:
> >
> > Modify the suspend_test() function to make the test delay can be
> > interrupted by wakeup events.
> >
> > This improves the responsiveness of the system during suspend testing
> > when wakeup events occur, allowing the suspend process to proceed
> > without waiting for the full test delay to complete when wakeup events
> > are detected.
> >
> > Additionally, using msleep() instead of mdelay() avoids potential soft
> > lockup "CPU stuck" issues when long test delays are configured.
> >
> > Co-developed-by: xiongxin <xiongxin@kylinos.cn>
> > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> > ---
> >  kernel/power/suspend.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index b4ca17c2fecf..1c2f777da367 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -344,10 +344,14 @@ MODULE_PARM_DESC(pm_test_delay,
> >  static int suspend_test(int level)
> >  {
> >  #ifdef CONFIG_PM_DEBUG
> > +       int i;
> > +
> >         if (pm_test_level =3D=3D level) {
> >                 pr_info("suspend debug: Waiting for %d second(s).\n",
> >                                 pm_test_delay);
> > -               mdelay(pm_test_delay * 1000);
> > +               for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending()=
; i++)
> > +                       msleep(1000);
> > +
> >                 return 1;
> >         }
> >  #endif /* !CONFIG_PM_DEBUG */
> > --
>=20
> Applied as 6.19 material, thanks!

This is now upstream as a10ad1b10402 ("PM: suspend: Make pm_test delay inte=
rruptible by wakeup events").
When doing the following PM debugging test on ROCK 4D on v6.19-rc2

echo N > /sys/module/printk/parameters/console_suspend
echo 1 > /sys/power/pm_print_times
echo 1 > /sys/power/pm_debug_messages
echo core > /sys/power/pm_test
echo mem > /sys/power/state

I see the following error triggered reliably, which did not happen on 6.18
and no longer appears after reverting this patch:

[   49.647656] ------------[ cut here ]------------
[   49.647656] WARNING: kernel/time/timekeeping.c:821 at ktime_get+0xb8/0xd=
8, CPU#0: swapper/0/0
[   49.647656] Modules linked in: sha256 cfg80211 binfmt_misc fuse ipv6 snd=
_soc_hdmi_codec rk805_pwrkey rockchip_saradc dwmac_rk stmmac_platform rtc_h=
ym8563 snd_soc_es8328_i2c phy_rockchip_usbdp rockchipdrm stmmac snd_soc_es8=
328 dw_hdmi_qp industrialio_triggered_buffer analogix_dp typec phy_rockchip=
_samsung_hdptx kfifo_buf dw_dp rockchip_thermal dw_mipi_dsi spi_rockchip_sf=
c phy_rockchip_naneng_combphy pcs_xpcs panfrost drm_shmem_helper gpu_sched =
snd_soc_rockchip_sai snd_soc_simple_card drm_dp_aux_bus dw_hdmi snd_soc_sim=
ple_card_utils rfkill_gpio rfkill snd_soc_core drm_display_helper snd_compr=
ess cec drm_client_lib drm_dma_helper display_connector snd_pcm_dmaengine d=
rm_kms_helper snd_pcm drm snd_timer snd backlight soundcore adc_keys
[   49.647656] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc2-=
g7211b2cf9c08 #1 PREEMPT
[   49.647656] Hardware name: Radxa ROCK 4D (DT)
[   49.647656] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   49.647656] pc : ktime_get+0xb8/0xd8
[   49.647656] lr : tick_nohz_idle_enter+0x50/0x90
[   49.647656] sp : ffffc1a17b573d50
[   49.647656] x29: ffffc1a17b573d50 x28: 00000000fdf57ec0 x27: ffffc1a17b5=
7b260
[   49.647656] x26: ffffc1a17b57e000 x25: 0000000000000000 x24: 00000000000=
000ea
[   49.647656] x23: ffffc1a17a470000 x22: ffffc1a17b57ad00 x21: ffff3e6282a=
25000
[   49.647656] x20: ffff0003fdead5d8 x19: ffffc1a17b4885d8 x18: 00000000000=
0000a
[   49.647656] x17: ffff3e6282a25000 x16: ffff800080000000 x15: 00700ea231d=
1d404
[   49.647656] x14: 0000000000000396 x13: 0000000000000001 x12: 00000000000=
00001
[   49.647656] x11: 00000000000000c0 x10: 0000000000000aa0 x9 : ffffc1a17b5=
73d00
[   49.647656] x8 : ffffc1a17b586680 x7 : 0000000000000000 x6 : 00000000000=
00000
[   49.647656] x5 : 0000000000000004 x4 : ffffc1a17b57eb68 x3 : 00000000000=
00000
[   49.647656] x2 : ffffc1a17b48ec40 x1 : 0000000000000000 x0 : 00000000000=
00001
[   49.647656] Call trace:
[   49.647656]  ktime_get+0xb8/0xd8 (P)
[   49.647656]  tick_nohz_idle_enter+0x50/0x90
[   49.647656]  do_idle+0x38/0x260
[   49.647656]  cpu_startup_entry+0x38/0x40
[   49.647656]  rest_init+0xd8/0xe0
[   49.647656]  console_on_rootfs+0x0/0x6c
[   49.647656]  __primary_switched+0x88/0x90
[   49.647656] ---[ end trace 0000000000000000 ]---

Greetings,

-- Sebastian

--6lymdjenuo2frg5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlLBOIACgkQ2O7X88g7
+pozrhAApMMmy8xT4ahq3B0jtFJzrxLWqU867KlUv7R/8cLH6sl1Fota9BneSLun
twK+/tqSQAdYZWw9eCKzfUNqkDcpQC7Uv2zST01Ee2WJ9iHqWza/ggvCU5kB1iuR
UqmTwwXix3DgrgMjWwRN3HdcsUyelPBDESOZe6kJ2qOLLJspit/bcriVSTtKl0Mp
X9RhreEDSBBJ0zuFyaA0Uli7vII9MIs5pK5ymR4Wy9rIYCWEcqPZezgpRcT7XZma
3Vz4VMI+W6QwBCH2mpR7Gzz3yjgLmL1DIZg+GUWAYzqyoDeafPCN6Oj5++UkT4M6
dGdnapJwA21jgbjNd3UOEi0kZpRAr53M4hGZ4uiofXTXm6iGgSk1d0+v4J8GVMrD
SAP8DdR4e8brVx5Koc5Fyq/+XAiR0/ZBLRSHdnvWP3xh5e7Um5Gt74Hx82mKhXZz
g6ml6bdM/5BXQ79Ywh4ASqgDJ4Hypq+QMvIbJ2FZLfYy0Vva50HLoQI1pBRmaD08
l+TRAu4dPbQlSeAl4QZR4vcg/m3Q3216rwRR067hGp0rbCvFf0wXQ9Fq63pFZr+X
bbC18uim5R04oUmkco0+5mB3OkCZ1K1Ug/H6SCfMq7grLqyu/nQwJISJgekFxlsU
Ec4lPFWFTuUTkOXoe4tacLLAIzKO973eMUeEGHLHnH7ZgkcyRyM=
=u5y6
-----END PGP SIGNATURE-----

--6lymdjenuo2frg5f--

