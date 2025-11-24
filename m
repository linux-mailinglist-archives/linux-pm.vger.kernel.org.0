Return-Path: <linux-pm+bounces-38434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFCC7FCD5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97D63A2FEF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091DF2F60DB;
	Mon, 24 Nov 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fi7nIrOp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6724A043
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978812; cv=none; b=Kr324MWzryc0aGOThOT5KXuEOdSGZkoovxa3w6VzzVg3FJGlQa2gLlVMAWiHuRipzxu+otwyFPRdm7eooNpWuhfO3HmVDm++epS5Te4Lh7qFt5N21J05N7G1RGebS3P0N+ZXu9zCLLrnITQ2hh5KOXGaEv+bxMqj79vR7vNRc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978812; c=relaxed/simple;
	bh=ot8hkFeIo/UEuyzJDh/y9H2Galv1zgqlnaHSJR4Vh40=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=iwAKXFfIwm1wkwZG4pOOgHdXk080eJjYfO5D14/x6ZvqFqSMqzmcXoCY8iOyxEY/j1b7fPNwrMWTrWXInuBCmhaUodM8sAkaQ3+zvCEF7A8+ZPmEArP7sOSHCBGG/NWmG4hJ010su9VjLh0L7C/YwopJ3EF4fl4GiIJjqWthW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Fi7nIrOp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251124100641epoutp042ba669b550e638ab8d357a2abe6099d8~66V-MqgTF2736027360epoutp04Y
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:06:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251124100641epoutp042ba669b550e638ab8d357a2abe6099d8~66V-MqgTF2736027360epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763978801;
	bh=518PqviNXgLoda/W13kyXia8krI82Z2gN0kxwjhBdwY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Fi7nIrOpoegc7az/EYd3pi6apnrHP7xP+8sareZg4K9ApTXV20sUTtmfHAoRZyy6a
	 VKysoaT0zHd017Jg1YyilFHcdKU9SEylYjG4QT9BciYD+pdlia4aavHbOT3+Elze8K
	 MtXbmQN8u1sd5eGxEyK4p8/BRWDM14NnF7ogp9cU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20251124100641epcas2p155850be961958980e0318057e970fbef~66V_uI9Os1469814698epcas2p1K;
	Mon, 24 Nov 2025 10:06:41 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.204]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dFM1D5XcDz2SSKY; Mon, 24 Nov
	2025 10:06:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20251124100639epcas2p1497455bf036f5c82178f129b59fbbe86~66V9Qgz4R1469814698epcas2p1G;
	Mon, 24 Nov 2025 10:06:39 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251124100639epsmtip21c1959008965844f498e49b5c01927d9~66V9JltAm1979019790epsmtip2S;
	Mon, 24 Nov 2025 10:06:39 +0000 (GMT)
From: =?utf-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Daniel Lezcano'" <daniel.lezcano@linaro.org>, "'Bartlomiej
 Zolnierkiewicz'" <bzolnier@gmail.com>, "'Krzysztof Kozlowski'"
	<krzk@kernel.org>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Zhang Rui'"
	<rui.zhang@intel.com>, "'Lukasz Luba'" <lukasz.luba@arm.com>, "'Rob
	Herring'" <robh@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>, "'Alim
	Akhtar'" <alim.akhtar@samsung.com>
Cc: "'Henrik Grimler'" <henrik@grimler.se>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<shin.son@samsung.com>
In-Reply-To: <2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Mon, 24 Nov 2025 19:06:33 +0900
Message-ID: <000001dc5d2a$0697bf10$13c73d30$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KIBiaSaQbPdi13w
Content-Language: ko
X-CMS-MailID: 20251124100639epcas2p1497455bf036f5c82178f129b59fbbe86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237
References: <20251113064022.2701578-1-shin.son@samsung.com>
	<CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
	<20251113064022.2701578-3-shin.son@samsung.com>
	<2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>

Hello, Daniel Lezcano

> On 11/13/25 07:40, Shin Son wrote:
> > +	if (data->soc =3D=3D SOC_ARCH_EXYNOSAUTOV920 && code_diff < 0)
> > +		temp =3D temp * 65 / (57 + data->slope_comp);
>=20
> No litterals, comments, etc ...

I'll move those fomulas into the variant data via the .data field in the of=
_device_id match table.

> > +static void update_con_reg(struct exynos_tmu_data *data) =7B
> > +	u32 val, t_buf_vref_sel, t_buf_slope_sel;
> > +
> > +	val =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> > +	t_buf_vref_sel =3D (val >> EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT)
> > +				& EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK;
> > +	t_buf_slope_sel =3D (val >> EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT)
> > +				& EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK;
> > +
> > +	val =3D readl(data->base +  EXYNOSAUTOV920_TMU_REG_CONTROL);
> > +	val &=3D =7E(EXYNOS_TMU_REF_VOLTAGE_MASK <<
> EXYNOS_TMU_REF_VOLTAGE_SHIFT);
> > +	val =7C=3D (t_buf_vref_sel << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
> > +	val &=3D =7E(EXYNOS_TMU_BUF_SLOPE_SEL_MASK <<
> EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
> > +	val =7C=3D (t_buf_slope_sel << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
> > +	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
> > +
> > +	val =3D readl(data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
> > +	val &=3D =7E(EXYNOSAUTOV920_TMU_NUM_PROBE_MASK <<
> EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
> > +	val &=3D =7E(EXYNOSAUTOV920_TMU_LPI_MODE_MASK <<
> EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT);
> > +	val =7C=3D (data->sensor_count << EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT)=
;
> > +	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
> > +
> > +	writel(1, data->base + EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL);
> > +	writel(EXYNOSAUTOV920_TMU_AVG_CON_UPDATE, data->base +
> EXYNOSAUTOV920_TMU_REG_AVG_CONTROL);
> > +	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE,
> > +	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0);
> > +	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE,
> > +	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1);
> > +=7D
> > +
>=20
> This is unreadable; please make it understandable for those who don=E2=80=
=99t=20have=0D=0A>=20the=20documentation=20(explicit=20static=20inline=20fu=
nctions,=20comments,=20etc=20...).=0D=0A=0D=0AI'll=20restructure=20this=20c=
ode=20by=20introducing=20explicit=20static=20inline=20helper=20functions=20=
and=20proper=20comments=20to=20improve=20readability.=0D=0A=0D=0A>=20>=20+s=
tatic=20void=20exynosautov920_tmu_disable_high(struct=20exynos_tmu_data=0D=
=0A>=20>=20+*data)=20=7B=0D=0A>=20>=20+=09/*=20Again,=20this=20is=20handled=
=20by=20polling.=20*/=20=7D=0D=0A>=20=0D=0A>=20The=20driver=20would=20deser=
ve=20some=20cleanups.=20Instead=20of=20having=20empty=20callbacks,=0D=0A>=
=20check=20in=20exynos_set_trips()=20if=20the=20ops=20is=20=21NULL.=20Then=
=20remove=20all=20no-op=20ops.=0D=0A=0D=0AOk,=20I'll=20update=20exynos_set_=
trips()=20to=20check=20for=20NULL=20ops=20and=20remove=20the=20no-op=20call=
backs=20accordingly.=0D=0A=0D=0A>=20>=20+static=20void=20exynosautov920_tmu=
_set_crit_temp(struct=20exynos_tmu_data=0D=0A>=20>=20+*data,=20u8=20temp)=
=20=7B=0D=0A>=20>=20+=09unsigned=20int=20idx;=0D=0A>=20>=20+=0D=0A>=20>=20+=
=09for=20(idx=20=3D=200;=20idx=20<=20data->sensor_count;=20idx++)=20=7B=0D=
=0A>=20>=20+=09=09if=20(=21data->tzd_array=5Bidx=5D)=0D=0A>=20>=20+=09=09=
=09continue;=0D=0A>=20>=20+=0D=0A>=20>=20+=09=09exynos_tmu_update_temp(data=
,=0D=0A>=20EXYNOSAUTOV920_TMU_REG_THRESHOLD(idx),=2016,=20temp);=0D=0A>=20>=
=20+=09=09exynos_tmu_update_bit(data,=0D=0A>=20EXYNOSAUTOV920_TMU_REG_INTEN=
(idx),=207,=20true);=0D=0A>=20>=20+=09=7D=0D=0A>=20>=20+=7D=0D=0A>=20=0D=0A=
>=20There=20is=20something=20wrong=20in=20the=20driver=20design.=0D=0A>=20=
=0D=0A>=20exynosautov920_tmu_set_crit_temp()=20is=20called=20from=0D=0A>=20=
exynos_thermal_zone_configure()=20and=20the=20routine=20above=20sets=20the=
=20temperature=0D=0A>=20on=20all=20the=20thermal=20zone=20while=20this=20on=
e=20is=20retrieved=20from=20one=20thermal=20zone.=0D=0A>=20=0D=0A>=20Which=
=20results=20in:=0D=0A>=20=0D=0A>=20=09for=20all=20tz=20do;=0D=0A>=20=09=09=
for=20all=20tz=20do;=0D=0A>=20=09=09=09if=20=21tz=20then=20continue;=0D=0A>=
=20=09=09=09set_crit_temp(tz)=0D=0A>=20=0D=0A>=20No,=20this=20driver=20need=
s=20to=20be=20revisited=20and=20cleanup=20before=20sending=20changes=0D=0A>=
=20for=20multiple=20sensors=20support.=0D=0A>=20=0D=0A>=20What=20percentage=
=20of=20code=20sharing=20is=20there=20with=20the=20existing=20driver=20?=0D=
=0A=0D=0AOverall,=20I=20would=20say=20that=20roughly=2060%=20of=20the=20log=
ic=20can=20be=20shared.=0D=0AThe=20temperature=20reading=20and=20emulation=
=20paths=20are=20similar,=20but=20the=20initialization=20sequence=20differs=
=20significantly.=0D=0A=0D=0AGiven=20this=20level=20of=20divergence,=20woul=
d=20introducing=20a=20separate=20driver=20=0D=0A(instead=20of=20extending=
=20the=20current=20one=20with=20many=20special-case=20paths)=20be=20accepta=
ble?=0D=0A=0D=0A>=20>=20+static=20void=20exynosautov920_tmu_initialize(stru=
ct=20platform_device=0D=0A>=20>=20+*pdev)=20=7B=0D=0A>=20>=20+=09struct=20e=
xynos_tmu_data=20*data=20=3D=20platform_get_drvdata(pdev);=0D=0A>=20>=20+=
=09unsigned=20int=20val;=0D=0A>=20>=20+=0D=0A>=20>=20+=09data->tmu_control(=
pdev,=20false);=0D=0A>=20>=20+=0D=0A>=20>=20+=09update_con_reg(data);=0D=0A=
>=20>=20+=0D=0A>=20>=20+=09val=20=3D=20readl(data->base=20+=20EXYNOS_TMU_RE=
G_TRIMINFO);=0D=0A>=20>=20+=09data->cal_type=20=3D=20TYPE_TWO_POINT_TRIMMIN=
G;=0D=0A>=20>=20+=09data->slope_comp=20=3D=20(val=20>>=20EXYNOSAUTOV920_SLO=
PE_COMP)=20&=0D=0A>=20>=20+EXYNOSAUTOV920_SLOPE_COMP_MASK;=0D=0A>=20>=20+=
=0D=0A>=20>=20+=09val=20=3D=20readl(data->base=20+=20EXYNOSAUTOV920_SENSOR0=
_TRIM_INFO);=0D=0A>=20>=20+=09data->temp_error1=20=3D=20(val=20>>=20EXYNOSA=
UTOV920_TRIMINFO_25_SHIFT)=20&=0D=0A>=20EXYNOSAUTOV920_TRIM_MASK;=0D=0A>=20=
>=20+=09data->temp_error2=20=3D=20(val=20>>=20EXYNOSAUTOV920_TRIMINFO_85_SH=
IFT)=20&=0D=0A>=20>=20+EXYNOSAUTOV920_TRIM_MASK;=0D=0A>=20>=20+=0D=0A>=20>=
=20+=09val=20=3D=20readl(data->base=20+=20EXYNOSAUTOV920_TMU_REG_TRIMINFO2)=
;=0D=0A>=20>=20+=09val=20=3D=20(val=20>>=20EXYNOSAUTOV920_CALIB_SEL_TEMP)=
=20&=0D=0A>=20>=20+EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK;=0D=0A>=20>=20+=0D=0A=
>=20>=20+=09data->calib_temp=20=3D=20(EXYNOS_SECOND_POINT_TRIM=20+=20(20=20=
*=20val));=20=7D=0D=0A>=20>=20+=0D=0A>=20=0D=0A>=20This=20is=20unreadable;=
=20please=20make=20it=20understandable=20for=20those=20who=20don=E2=80=99t=
=20have=0D=0A>=20the=20documentation=20(explicit=20static=20inline=20functi=
ons,=20comments,=20etc=20...).=0D=0A=0D=0AOk,=20I'll=20refactor=20this=20co=
de=20using=20explicit=20static=20inline=20helpers=20and=20comments.=0D=0A=
=0D=0A>=20>=20+static=20void=20exynosautov920_tmu_control(struct=20platform=
_device=20*pdev,=0D=0A>=20>=20+bool=20on)=20=7B=0D=0A>=20>=20+=09struct=20e=
xynos_tmu_data=20*data=20=3D=20platform_get_drvdata(pdev);=0D=0A>=20>=20+=
=09unsigned=20int=20con;=0D=0A>=20>=20+=0D=0A>=20>=20+=09con=20=3D=20readl(=
data->base=20+=20EXYNOSAUTOV920_TMU_REG_CONTROL);=0D=0A>=20>=20+=0D=0A>=20>=
=20+=09if=20(on)=20=7B=0D=0A>=20>=20+=09=09con=20=7C=3D=20BIT(EXYNOS_TMU_TH=
ERM_TRIP_EN_SHIFT);=0D=0A>=20>=20+=09=09con=20=7C=3D=20BIT(EXYNOS_TMU_CORE_=
EN_SHIFT);=0D=0A>=20>=20+=09=7D=20else=20=7B=0D=0A>=20>=20+=09=09con=20&=3D=
=20=7EBIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);=0D=0A>=20>=20+=09=09con=20&=3D=
=20=7EBIT(EXYNOS_TMU_CORE_EN_SHIFT);=0D=0A>=20>=20+=09=7D=0D=0A>=20>=20+=0D=
=0A>=20>=20+=09writel(con,=20data->base=20+=20EXYNOSAUTOV920_TMU_REG_CONTRO=
L);=20=7D=0D=0A>=20=0D=0A>=20Document=20a=20bit=20the=20code=20please.=0D=
=0A=0D=0ASure,=20I=E2=80=99ll=20document=20this=20part=20properly=20by=20ad=
ding=20clear=20comments=20and=20splitting=20the=20register=20options=20into=
=20explicit=20helper=20functions.=0D=0A=0D=0A>=20>=20=20=20static=20irqretu=
rn_t=20exynos_tmu_threaded_irq(int=20irq,=20void=20*id)=0D=0A>=20>=20=20=20=
=7B=0D=0A>=20>=20=20=20=09struct=20exynos_tmu_data=20*data=20=3D=20id;=0D=
=0A>=20>=20+=09int=20idx;=0D=0A>=20>=0D=0A>=20>=20-=09thermal_zone_device_u=
pdate(data->tzd,=20THERMAL_EVENT_UNSPECIFIED);=0D=0A>=20>=20+=09for=20(idx=
=20=3D=200;=20idx=20<=20data->sensor_count;=20idx++)=20=7B=0D=0A>=20>=20+=
=09=09if=20(=21data->tzd_array=5Bidx=5D)=0D=0A>=20>=20+=09=09=09continue;=
=0D=0A>=20>=20+=0D=0A>=20>=20+=09=09thermal_zone_device_update(data->tzd_ar=
ray=5Bidx=5D,=0D=0A>=20>=20+THERMAL_EVENT_UNSPECIFIED);=0D=0A>=20I=20unders=
tand=20the=20main=20reason=20is=20to=20keep=20a=20common=20isr=20but=20you=
=20should=0D=0A>=20*not*=20update=20all=20the=20thermal=20zones.=20There=20=
is=20an=20amount=20of=20processing=0D=0A>=20behind=20this=20function=20addi=
ng=20a=20significant=20overhead.=0D=0A>=20=0D=0A>=20So=20somehow=20readl(da=
ta->base=20+=20EXYNOSAUTOV920_TMU_REG_INT_PEND(idx));=0D=0A>=20should=20be=
=20used=20here=20to=20know=20if=20the=20thermal=20zone=20has=20to=20be=20up=
dated=20or=20not.=0D=0A=0D=0AOK,=20I'll=20update=20the=20ISR=20so=20that=20=
it=20checks=20the=20pending=20register=20before=20calling=20'thermal_zone_d=
evice_update()',=0D=0AAnd=20only=20update=20the=20relevant=20thermal=20zone=
s.=20=0D=0A=0D=0A>=20>=20=20=20static=20const=20struct=20of_device_id=20exy=
nos_tmu_match=5B=5D=20=3D=20=7B=0D=0A>=20>=20=20=20=09=7B=0D=0A>=20>=20=20=
=20=09=09.compatible=20=3D=20=22samsung,exynos3250-tmu=22,=20=40=40=20-833,=
6=20+1044,9=20=40=40=0D=0A>=20>=20static=20const=20struct=20of_device_id=20=
exynos_tmu_match=5B=5D=20=3D=20=7B=0D=0A>=20>=20=20=20=09=7D,=20=7B=0D=0A>=
=20>=20=20=20=09=09.compatible=20=3D=20=22samsung,exynos7-tmu=22,=0D=0A>=20=
>=20=20=20=09=09.data=20=3D=20(const=20void=20*)SOC_ARCH_EXYNOS7,=0D=0A>=20=
>=20+=09=7D,=20=7B=0D=0A>=20>=20+=09=09.compatible=20=3D=20=22samsung,exyno=
sautov920-tmu=22,=0D=0A>=20>=20+=09=09.data=20=3D=20(const=20void=20*)SOC_A=
RCH_EXYNOSAUTOV920,=0D=0A>=20=0D=0A>=20Time=20to=20do=20cleanups=20in=20the=
=20driver.=20Use=20at=20your=20advantage=20the=20.data=20to=0D=0A>=20store=
=20the=20relevant=20info=20instead=20of=20a=20awful=20else-if=20in=20the=20=
different=0D=0A>=20functions=20above.=0D=0A=0D=0AOK,=20I'll=20refactor=20th=
is=20by=20using=20the=20.data=20field.=0D=0AHowever,=20since=20ExynosAutov9=
20=20diverges=20significantly=20from=20the=20existing=20driver,=0D=0AWould=
=20introducing=20a=20separate=20driver=20instead=20of=20unifying=20everythi=
ng=20be=20acceptable?=0D=0A=0D=0A>=20>=20=20=20=09=7D,=0D=0A>=20>=20=20=20=
=09=7B=20=7D,=0D=0A>=20>=20=20=20=7D;=0D=0A>=20>=20=40=40=20-865,6=20+1079,=
10=20=40=40=20static=20int=20exynos_map_dt_data(struct=0D=0A>=20>=20platfor=
m_device=20*pdev)=0D=0A>=20>=0D=0A>=20>=20=20=20=09data->soc=20=3D=20(uintp=
tr_t)of_device_get_match_data(&pdev->dev);=0D=0A>=20>=0D=0A>=20>=20+=09data=
->sensor_count=20=3D=20EXYNOS_DEFAULT_SENSOR_COUNT;=0D=0A>=20>=20+=0D=0A>=
=20>=20+=09data->calib_temp=20=3D=20EXYNOS_SECOND_POINT_TRIM;=0D=0A>=20>=20=
+=0D=0A>=20>=20=20=20=09switch=20(data->soc)=20=7B=0D=0A>=20>=20=20=20=09ca=
se=20SOC_ARCH_EXYNOS4210:=0D=0A>=20>=20=20=20=09=09data->tmu_set_low_temp=
=20=3D=20exynos4210_tmu_set_low_temp;=20=40=40=20-=0D=0A>=20945,6=0D=0A>=20=
>=20+1163,19=20=40=40=20static=20int=20exynos_map_dt_data(struct=20platform=
_device=20*pdev)=0D=0A>=20>=20=20=20=09=09data->min_efuse_value=20=3D=2015;=
=0D=0A>=20>=20=20=20=09=09data->max_efuse_value=20=3D=20100;=0D=0A>=20>=20=
=20=20=09=09break;=0D=0A>=20>=20+=09case=20SOC_ARCH_EXYNOSAUTOV920:=0D=0A>=
=20>=20+=09=09data->tmu_set_low_temp=20=3D=20exynosautov920_tmu_set_low_tem=
p;=0D=0A>=20>=20+=09=09data->tmu_set_high_temp=20=3D=20exynosautov920_tmu_s=
et_high_temp;=0D=0A>=20>=20+=09=09data->tmu_disable_low=20=3D=20exynosautov=
920_tmu_disable_low;=0D=0A>=20>=20+=09=09data->tmu_disable_high=20=3D=20exy=
nosautov920_tmu_disable_high;=0D=0A>=20>=20+=09=09data->tmu_set_crit_temp=
=20=3D=20exynosautov920_tmu_set_crit_temp;=0D=0A>=20>=20+=09=09data->tmu_in=
itialize=20=3D=20exynosautov920_tmu_initialize;=0D=0A>=20>=20+=09=09data->t=
mu_control=20=3D=20exynosautov920_tmu_control;=0D=0A>=20>=20+=09=09data->tm=
u_read=20=3D=20exynosautov920_tmu_read;=0D=0A>=20>=20+=09=09data->tmu_set_e=
mulation=20=3D=20exynos4412_tmu_set_emulation;=0D=0A>=20>=20+=09=09data->tm=
u_clear_irqs=20=3D=20exynosautov920_tmu_clear_irqs;=0D=0A>=20>=20+=09=09dat=
a->sensor_count=20=3D=20EXYNOS_MAX_SENSOR_COUNT;=0D=0A>=20>=20+=09=09break;=
=0D=0A>=20=0D=0A>=20Same=20comment=20as=20above.=0D=0A=0D=0AOk,=20I'll=20re=
factor=20this=20by=20using=20the=20.data=20field=20to=20move=20the=20SoC-sp=
ecific=20callbacks=20into=20a=20proper=0D=0Avariant=20structure.=0D=0A=0D=
=0A>=20--=0D=0A=0D=0AThank=20you=20for=20your=20detailed=20feedback.=20I=20=
appreciate=20it.=0D=0A=0D=0A=0D=0A

