Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7A52065
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfFYBm3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 21:42:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17913 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfFYBm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 21:42:27 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190625014223epoutp0315d0bb2ef000ff36dbd9ecbc3d323dd7~rTYgtYvkn2623626236epoutp03o
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 01:42:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190625014223epoutp0315d0bb2ef000ff36dbd9ecbc3d323dd7~rTYgtYvkn2623626236epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561426943;
        bh=Q+wSE1D1mkFPZ3kbjNBSBDW6V8ZYgQZcbvAOHEb9UBw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ilPzVsZM5LcPCnpIXO9KGG1sIxvKCVsnZgcdv8IOz8Jt7t0NgV/ldqJMLrTEz1eGD
         ezbR+FYhwGnG8VocWUy3W6vEWC4mZN/U0SxROI/gO2lm2AKsr/FBBc2Iq0z2GmuVUq
         3D5RqORgFlML4QAQtft/rtu/zIgCBDpTyx3muQ+4=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190625014219epcas1p18d32dff3ac18bf156107086369b628a0~rTYdK9I8B2220822208epcas1p1V;
        Tue, 25 Jun 2019 01:42:19 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-44-5d117bf69493
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.F9.04139.6FB711D5; Tue, 25 Jun 2019 10:42:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <7561edbc-c17c-101a-b339-fc7f9968a470@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190625014214epcms1p1b8f2d76cd8cfdf3fdf517be08a92ccdf@epcms1p1>
Date:   Tue, 25 Jun 2019 10:42:14 +0900
X-CMS-MailID: 20190625014214epcms1p1b8f2d76cd8cfdf3fdf517be08a92ccdf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTT/dbtWCswfQJkhbXvzxntVj98TGj
        RcusRSwWl3fNYbP43HuE0aLzyyw2i5+75rE4sHvsnHWX3aO3+R2bR9+WVYwenzfJBbBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2gpFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjOuPd9
        NmvBHbGKSVfOsjQwdoh1MXJwSAiYSLxYEdfFyMUhJLCDUeL/whlsIHFeAUGJvzuEuxg5OYQF
        3CS2XfvNAmILCShJNNzcxwwR15foeLCNEcRmE9CV2LrhLliNiICaxPKjf1hBZjILnGaS2Lz2
        JxtIQkKAV2JG+1MWCFtaYvvyrWDNnAK2Et2/vjFBxEUlbq5+yw5jvz82nxHCFpFovXeWGcIW
        lHjwczcjzJwZU/5DzayWuDZ9MTvIYgmBFkaJ3tVToIr0Jc7MPQn1mK/EyTVlIGEWAVWJ6Q/X
        Q810keg5NRnsBmYBbYllC18zg5QzC2hKrN+lD1GiKLHz91xGiBI+iXdfe1hh3tox7wnU+WoS
        h3YvgTpfRuL09IVQ4z0kXpzYxwoJ52Zmie7X89gmMCrMQgT1LCSbZyFsXsDIvIpRLLWgODc9
        tdiwwBA5cjcxghOjlukOxinnfA4xCnAwKvHw/jgmECvEmlhWXJl7iFGCg1lJhHdpIlCINyWx
        siq1KD++qDQntfgQoykwACYyS4km5wOTdl5JvKGpkbGxsYWJoZmpoaGSOG88980YIYH0xJLU
        7NTUgtQimD4mDk6pBsZplrqcW6N2N0w8fa8+9uztw8ur1LLmzN3GdqzkoymzlYERo3bCsmXP
        /35/sDuUT7ls/98rd/9lBpxwurIxyGCa8YX3eio3/j9baJFXaj2z7cM+j9Ce1SlnJqRPWGCr
        y5fw8s4WsRffVePVD/Avj5jG2/dq/9PpjlsOX/CfqHLyR2RnypcTbOWmSizFGYmGWsxFxYkA
        Ew20XKIDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f
References: <7561edbc-c17c-101a-b339-fc7f9968a470@gmail.com>
        <37db00bc-3a22-d1c2-7bdc-e27af42cd5c7@gmail.com>
        <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
        <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
        <20190624111134epcms1p361aed3c72edd6eebc95408331c8d9739@epcms1p3>
        <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sender : Dmitry Osipenko <digetx=40gmail.com>
>24.06.2019 14:11, MyungJoo Ham =D0=BF=D0=B8=D1=88=D0=B5=D1=82:=0D=0A>>>=0D=
=0A>>>=20---------=20Original=20Message=20---------=0D=0A>>>=20Sender=20:=
=20Dmitry=20Osipenko=20<digetx=40gmail.com>=0D=0A>>>=0D=0A>>>=2024.06.2019=
=2010:34,=20MyungJoo=20Ham=20=D0=BF=D0=B8=D1=88=D0=B5=D1=82:=0D=0A>>>>>=0D=
=0A>>>>>=20A=20question:=0D=0A>>>>>=0D=0A>>>>>=20Does=20this=20driver=20sup=
port=20Tegra20=20as=20well?=0D=0A>>>>>=20I'm=20asking=20this=20because=20AR=
CH_TEGRA=20includes=20ARCH_TEGRA_2x_SOC=0D=0A>>>>>=20according=20to=20/driv=
ers/soc/tegra/Kconfig.=0D=0A>>>>>=0D=0A>>>>=0D=0A>>>>=20For=20this=20matter=
,=20how=20about=20updating=20your=2013/16=20patch=20as=20follows?=0D=0A>>>>=
=0D=0A>>=20=5B=5D=0D=0A>>>=0D=0A>>>=20Good=20call=21=20I'll=20update=20this=
=20patch=20following=20yours=20suggestion,=20thanks.=0D=0A>>=20=0D=0A>>=20O=
r,=20you=20may=20approve=20the=20modified=20commits=20here:=0D=0A>>=20https=
://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/log/?h=3Dfor-nex=
t=0D=0A>=20=0D=0A>Looks=20almost=20good=20to=20me=21=0D=0A>=20=0D=0A>I=20ju=
st=20recalled=20that=20there=20is=20also=20a=2064bit=20variant=20of=20Tegra=
124,=20the=20Tegra132.=20Hence=0D=0A>the=20Tegra30+=20Kconfig=20entry=20sho=
uld=20look=20like=20this=20(it's=20also=20worthy=20to=20break=20the=20lines=
=0D=0A>for=20readability):=0D=0A>=20=0D=0A>diff=20--git=20a/drivers/devfreq=
/Kconfig=20b/drivers/devfreq/Kconfig=0D=0A>index=20ccb1a68c4b51..bd2efbc277=
25=20100644=0D=0A>---=20a/drivers/devfreq/Kconfig=0D=0A>+++=20b/drivers/dev=
freq/Kconfig=0D=0A>=40=40=20-94,7=20+94,10=20=40=40=20config=20ARM_EXYNOS_B=
US_DEVFREQ=0D=0A>=20=0D=0A>=20config=20ARM_TEGRA_DEVFREQ=0D=0A>=20=20=20=20=
=20=20=20=20tristate=20=22NVIDIA=20Tegra30/114/124/210=20DEVFREQ=20Driver=
=22=0D=0A>-=20=20=20=20=20=20=20depends=20on=20ARCH_TEGRA=20=7C=7C=20COMPIL=
E_TEST=0D=0A>+=20=20=20=20=20=20=20depends=20on=20ARCH_TEGRA_3x_SOC=20=20=
=7C=7C=20ARCH_TEGRA_114_SOC=20=7C=7C=20=5C=0D=0A>+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20ARCH_TEGRA_132_SOC=20=7C=7C=20ARCH_TEGRA_124_=
SOC=20=7C=7C=20=5C=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20ARCH_TEGRA_210_SOC=20=7C=7C=20=5C=0D=0A>+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20COMPILE_TEST=0D=0A>=20=20=20=20=20=20=20=20selec=
t=20PM_OPP=0D=0A>=20=20=20=20=20=20=20=20help=0D=0A>=20=20=20=20=20=20=20=
=20=20=20This=20adds=20the=20DEVFREQ=20driver=20for=20the=20Tegra=20family=
=20of=20SoCs.=0D=0A>=20=0D=0A>Could=20you=20please=20adjust=20the=20patches=
=20like=20I'm=20suggesting?=20I'll=20approve=20yours=20change=0D=0A>then=20=
and=20won't=20re-spin=20the=20first=20batch=20of=20the=20patches.=0D=0A=0D=
=0AI've=20adjusted=20as=20you=20suggested.=20It's=20pushed=20to=20the=20git=
=20repo=20as=20well.=0D=0A=0D=0ACheers,=0D=0AMyungJoo.=0D=0A=0D=0A
