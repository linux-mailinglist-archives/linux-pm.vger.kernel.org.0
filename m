Return-Path: <linux-pm+bounces-598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D7A8007A7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 10:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498FBB211B6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFED2033A;
	Fri,  1 Dec 2023 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D54GpXlU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE53C10FF
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 01:56:41 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095638euoutp01edbd254945129bc6520fe54d569abd4d~crKhY20Xc3266132661euoutp01q
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 09:56:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201095638euoutp01edbd254945129bc6520fe54d569abd4d~crKhY20Xc3266132661euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701424598;
	bh=106CZkth6hhVA2GeHffBolAXmeoKzLlk2xMt1fH43Hw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=D54GpXlU/BkUXdJ0xQ4tObKtgsTPEaGwTwoW4tCeN6e2pVCC2Y3Czk9dgUbwIvIEC
	 9zCSNE3YE2He8F+C+rvfnVwxKQ43Mi9PjVrLM4O1BsR/HJLPkh7eScNiDnMSuQ0LOA
	 1YxCxJB2wZbMLhCAFWbjwcydVFFE8Q6125oAM0UM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231201095637eucas1p24daf3a73854e038c995442c08df054c3~crKg22ki72503225032eucas1p2G;
	Fri,  1 Dec 2023 09:56:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.32.09814.5DDA9656; Fri,  1
	Dec 2023 09:56:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231201095637eucas1p25e14bd24e05ae61eb12dee18af2a1dc5~crKgXSBn11612516125eucas1p2W;
	Fri,  1 Dec 2023 09:56:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231201095637eusmtrp175840ba9962ac971a809e70c1b4a0c95~crKgWfadY0736407364eusmtrp1y;
	Fri,  1 Dec 2023 09:56:37 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-da-6569add5abbd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 92.20.09146.5DDA9656; Fri,  1
	Dec 2023 09:56:37 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231201095636eusmtip22e4e7027907d2125b29c0a2bde3512b9~crKfcYENZ1357813578eusmtip2I;
	Fri,  1 Dec 2023 09:56:36 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Alim Akhtar <alim.akhtar@samsung.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Lukasz Luba <lukasz.luba@arm.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v6 0/9] Improve Exynos thermal driver
Date: Fri,  1 Dec 2023 10:56:16 +0100
Message-ID: <20231201095625.301884-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7pX12amGsw6r27xYN42NovD8yss
	pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
	1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mq4dfo7S8Fl/oqe3RfYGhj38XQxcnJICJhI
	vPp9nq2LkYtDSGAFo8S6OU+YQRJCAl8YJVatioWwPzNK3H8UAtPQc3gfM0TDckaJYz+62SGc
	ViaJu2cPsYBUsQkYSDx4s4wdxBYRaGWUmNmkDmIzCyxkkWj5lwtiCwuYSvzdMw9sG4uAqsTJ
	/slA9ewcvAK2EtdFIHbJS+xZ9J0JxOYVEJQ4OfMJC8QUeYnmrbPBbpAQaOaU+H1yOhNEg4vE
	+vsX2SFsYYlXx7dA2TISpyf3sEDY+RIzNr8HsjmA7AqJuwe9IExriY9nmEFMZgFNifW79CGK
	HSWmtbVBFfNJ3HgrCHEAn8SkbdOZIcK8Eh1tQhDVqhLH90xihrClJZ603IY6y0Pi3Mxv7JCw
	jJVYPvcT+wRGhVlI3pqF5K1ZCDcsYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZja
	Tv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhvf40PVWINyWxsiq1KD++qDQntfgQozQHi5I4r2qK
	fKqQQHpiSWp2ampBahFMlomDU6qByWF6sPC6eM3jVcmPGNeVsVXv/GTfOas1T/boJafPCZM2
	P16UoP459ylTWWjwIfWM1h86hiLuvKp/pOunOWdUp9cKyqzlSDhxJ01f1Gq/sqju0iVva53l
	DhYENl3vOPSrlq1Tjj38y+1LupEZh87f0v3CFug+nf/4vq+/XylcqMy4O2VOiOK1w9Hnz2/f
	Yzjrz9u5VmketXtv9O1wcfO6df+NRvvSd0d3rNsh2vTeXnmS/eHdPD15T+TMJTWmcSz+3Cb9
	pYYzZPe8/If7tn/q+eHzNF310dMj3j9F4hz2Pog6eOPV25wVJt2Bwt9XaS+c3/pGasuRno/y
	O+d0/9ryZl/ghMfVcQp7rld1SU2NDFViKc5INNRiLipOBACUjeoN3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7pX12amGvx4ymzxYN42NovD8yss
	pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
	1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
	Sc3JLEst0rdL0Mu4dfo7S8Fl/oqe3RfYGhj38XQxcnJICJhI9BzexwxiCwksZZTYc9IYIi4t
	cfjLFHYIW1jiz7Uuti5GLqCaZiaJmxtOMoIk2AQMJB68WcYOkhAR6GSU6Np8jgnEYRZYzSJx
	bN93JpAqYQFTib975oGtYBFQlTjZPxmog52DV8BW4roIxAJ5iT2LIKp5BQQlTs58wgJiMwPF
	m7fOZp7AyDcLSWoWktQCRqZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgfG17djPzTsY5736
	qHeIkYmD8RCjBAezkgjv9afpqUK8KYmVValF+fFFpTmpxYcYTYGum8gsJZqcD4zwvJJ4QzMD
	U0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGph5vsYzCaZbWBrVdq9y3TtHd
	lW8cuO/Lgvd32XdKb0uOO+z8Zd9NSR2Rp61elvHPn10vzXTc6Riwmiew8tO76JSqV1z13VGP
	D9Q738mZL+dn6lXK9ni7+fVNkpNXvnmy2vXWAtXnZl7Z2zj3ssYdqNqx+Fn8wjVFP18unDrp
	dazdx4qvL1KfmXn+8T57ZVfk4z2notX5ze/+nxHfUpX97e5zlpee/26evB8s/NB3wfzPxffZ
	pJSUut9Fb7A7+JF/gdMG3lP/ezu9gzd8nLuia8rrdwXrvNM/6NfdCXkXMCNvvpSe/3cz/R1+
	29rzRfvKuCy/67iuKD6gcCFRPYOTK8ryOv82UzfGJQlBL/WSriuxFGckGmoxFxUnAgA0wCdI
	OAMAAA==
X-CMS-MailID: 20231201095637eucas1p25e14bd24e05ae61eb12dee18af2a1dc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095637eucas1p25e14bd24e05ae61eb12dee18af2a1dc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095637eucas1p25e14bd24e05ae61eb12dee18af2a1dc5
References: <CGME20231201095637eucas1p25e14bd24e05ae61eb12dee18af2a1dc5@eucas1p2.samsung.com>

This work improves Exynos thermal driver in various ways. This is
related to the discussion in
https://lore.kernel.org/all/97201878-3bb8-eac5-7fac-a690322ac43a@linaro.org/

The primary issue being fixed is a lockdep warning, which is fixed by
the thermal: exynos: use set_trips patch. We also simplify the code in
general.

Changelog:
 v6:
   - Fixed cleanup after split initialization failure
 v5:
   - Used BIT wherever possible
   - Simplified Exynos 7 code and used the correct register offsets for
     Exynos 7
   - Refactored some common register-setting code
 v4:
   - Resolved merge conflict when applying thermal: exynos: split
     initialization of TMU and the thermal zone
   - Reordered calls done when leaving exynos_tmu_initialize for
     symmetry
 v3:
   - Fixed regulator initialization
   - Fixed formatting of some comments
 v2:
   - Added missing field descriptions
   - Removed an unnecessary field description
   - Removed the commits that made clock management more fine-grained
     (need more discussion), and adapted the new code to manage clocks
   - Removed the devicetree changes (will be uploaded separately),
     changing the recipient list accordingly
   - Improved formatting of the devm_request_threaded_irq call

Mateusz Majewski (9):
  thermal: exynos: remove an unnecessary field description
  thermal: exynos: drop id field
  thermal: exynos: switch from workqueue-driven interrupt handling to
    threaded interrupts
  thermal: exynos: handle devm_regulator_get_optional return value
    correctly
  thermal: exynos: simplify regulator (de)initialization
  thermal: exynos: stop using the threshold mechanism on Exynos 4210
  thermal: exynos: split initialization of TMU and the thermal zone
  thermal: exynos: use BIT wherever possible
  thermal: exynos: use set_trips

 drivers/thermal/samsung/exynos_tmu.c | 547 ++++++++++++++-------------
 1 file changed, 274 insertions(+), 273 deletions(-)

-- 
2.42.0


