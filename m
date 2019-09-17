Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02131B46B0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 07:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfIQFBk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 01:01:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:15300 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbfIQFBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 01:01:40 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190917050138epoutp01d32d6fa025360a1da3cb3da56cc0201f~FISdwGQlv1465814658epoutp01T
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2019 05:01:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190917050138epoutp01d32d6fa025360a1da3cb3da56cc0201f~FISdwGQlv1465814658epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568696498;
        bh=6mHbpAUwyj7YTNcs3L/+wtjOe8slMuU1FPj19HPJbhQ=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Ff4fkKlUV3X1bSROFkKLGH0SwBMUcy9aSGz8Il41klMpNhvGkkGoVUlk73eyz/kMO
         ge0/ZbMnrfbYZaCdjYYqf1jvdStinD4Dgu8TOAFFyX2UEn0+xWfhZT0P/7UN0vxhYM
         J+4EFjXBSJlWGTIeJiSAbIsqW7i3yLtfvSla3TaA=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190917050138epcas1p2f96d9a83f382257d7793e4c6262fadf3~FISdbEnqQ0681506815epcas1p2C;
        Tue, 17 Sep 2019 05:01:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46XWDH5b4bzMqYkc; Tue, 17 Sep
        2019 05:01:35 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-01-5d8068af1cbd
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.B4.04085.FA8608D5; Tue, 17 Sep 2019 14:01:35 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v4 1/6] PM / devfreq: Don't take lock in
 devfreq_add_device
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190917050135epcms1p15ba77f52d2a34db0236fd81107dba07f@epcms1p1>
Date:   Tue, 17 Sep 2019 14:01:35 +0900
X-CMS-MailID: 20190917050135epcms1p15ba77f52d2a34db0236fd81107dba07f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQHd9RkOswd4FOhYvD2laXP/ynNVi
        xd2PrBabHl9jtfjce4TRgdVj85J6j43vdjB59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpm
        XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0FYlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG+1dtjAULWCta5/xhamDc
        x9LFyMkhIWAi0dmzmhXEFhLYwSjxbhtHFyMHB6+AoMTfHcIgYWGBQIkdny8zQ5QoSTTc3McM
        EdeX6HiwjRHEZhPQldi64S7YSBEBc4m7j+ezdzFycTALbGKU2L7qPhPELl6JGe1PofZKS2xf
        vpURwhaVuLn6LTuM/f7YfKi4iETrvbPMELagxIOfuxlhemdM+Q81p1ri2vTFYMskBFoYJXpX
        T4Eq0pc4M/ckG4jNK+Ar8XTFTrAjWARUJdrOPWGFqHGRuPRsGVicWUBbYtnC18wgzzMLaEqs
        36UPUaIosfP3XEaY+xs2/mZHZzML8Em8+9rDChPfMe8J1L9qEod2L4Gql5E4PX0h1C8eEm3b
        mlgmMCrOQgT1LCRHzEI4YgEj8ypGsdSC4tz01GLDAlPkyN3ECE6AWpY7GI+d8znEKMDBqMTD
        e2NzfawQa2JZcWXuIUYJDmYlEd6AWqAQb0piZVVqUX58UWlOavEhRlNgWExklhJNzgcm57yS
        eENTI2NjYwsTQzNTQ0MlcV6P9IZYIYH0xJLU7NTUgtQimD4mDk6pBsbJzye0tD6oOyUep32M
        U/pv/rTXd2ym7/Ry/XLyj8PL9Ci1f1ebmG8f7/6mr9E2e2WinMmcV4ofgwyXnymNzLg053yQ
        yozeq7cunNoWr9WyZ99cno+mGfdXL9LrVnINfHBZcnJnlPb81d0JJrZlxXc9Jbx/+L7deXPF
        sgfWl56q5LW8P3yo9iy7EktxRqKhFnNRcSIAWFDNf5YDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190917050135epcms1p15ba77f52d2a34db0236fd81107dba07f
References: <CGME20190917050135epcms1p15ba77f52d2a34db0236fd81107dba07f@epcms1p1>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>A device usually doesn't need to lock itself during initialization
>because it is not yet reachable from other threads.
>
>This simplifies the code and helps avoid recursive lock warnings.
>
>Signed-off-by: Leonard Crestez <leonard.crestez=40nxp.com>
>---



=46rom the line of=20

> err =3D device_register(&devfreq->dev);

Other threads may access the protected values.
Thus, if there are recursive lock warnings, we need to resolve it without e=
liminating lock usages.

=C2=A0=0D=0A--=0D=0AMyungJoo=20Ham=20(=ED=95=A8=EB=AA=85=EC=A3=BC),=20Ph.D.=
=0D=0AOn-Device=20Lab,=20Platform=20Team,=C2=A0Samsung=20Research.=0D=0ACel=
l:=20+82-10-6714-2858
