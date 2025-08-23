Return-Path: <linux-pm+bounces-32933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C574B32964
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9563A5305
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6C2E6138;
	Sat, 23 Aug 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X0xJpitM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A02E54AD;
	Sat, 23 Aug 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960422; cv=none; b=nRJc/4E3dROvedyp+KmN2RSDBQ6hQXzUphM+zDsHq7XGCCOmX18KhEXb0AND5L4tjLS8xQDPcxURz5oA/vVJeJxS9v6DqboEdxCZPq0LoPwCH/R88Z8Q8uhLFzEYyS6hQDDJ+AMIciZgeAHXZcTO/Hw5iv1a7+oRYG5r6ZMg/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960422; c=relaxed/simple;
	bh=cenfpGkljjvV4+pZBLnL38Jo0Mb2RZGK5lB4/sLKQFE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r/rAJEJHrkvbsjHnE3rpLkOSStwarXLy7+9G56xg+DWuCFOZ9BLTKqsNJVA9bkKfNudCw6PCSYp3gp/+OOb+c39gSwAfI75vMOplzy0o0BulDi7QkEIh4bXqAIDyJZfzZ8o0QirEW+F4t5iiysk277hkaHn9wkSsLPZ3qT++xOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=X0xJpitM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755960408; x=1756565208; i=markus.elfring@web.de;
	bh=cenfpGkljjvV4+pZBLnL38Jo0Mb2RZGK5lB4/sLKQFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X0xJpitMfpYJKUmrk7s/+b7A1YAzra7ryTKmNaJgYQL2kCsf4wLWFEOFPpChdJhV
	 pJUsO3m0BgpWOsrfYhNzL6cItgo1MxJbhp1NN6ew+97qXh3icLGWieVLS6bICUBEL
	 uOKzaNpKyR5pV2cnVFgiw73w+pxe2A6A72K9facMu73NhytH7OGecCLkxWeXGnqjO
	 dHhfM6bxYzu3IIc7L5qGHr8kic54pvcFdjpLwa5RnFIBMP+IgQw3FsldViKCi8soz
	 frmB2ElsNYwarq4ms8xQ++NoxdUSze8nMvQgJRHVDWQiiuxDZJn//HCaEnCixYMkH
	 T55OEKq5tPWt3+CvTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1uz9Ao3A5S-00QYCD; Sat, 23
 Aug 2025 16:46:48 +0200
Message-ID: <cac66cc0-c5f1-4bfe-ac43-5ece4a47cf15@web.de>
Date: Sat, 23 Aug 2025 16:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-pm@vger.kernel.org,
 kernel@pyra-handheld.com, letux-kernel@openphoenux.org,
 Jerry Lv <Jerry.Lv@axis.com>, Sebastian Reichel <sre@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>
References: <692f79eb6fd541adb397038ea6e750d4de2deddf.1755945297.git.hns@goldelico.com>
Subject: Re: [PATCH v2 1/2] power: supply: bq27xxx: fix error return in case
 of no bq27000 hdq battery
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <692f79eb6fd541adb397038ea6e750d4de2deddf.1755945297.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sDVZphkx/6Md0rgKCmdtwnMM6aRWlnVWYeNj8n4jRZZcSnDaOR9
 3htZw9EPf5QOV0/VrUl0+oulSXVCCcmJka0O3Y9MUkPVr3sT5TRztMBZCWHOEhVtMdhODgU
 923Mf6AwyT3zWYZ3j78hP9imW3u6sYND4GRhRpJlGMclK48D4d6Vi0GrypyhLgVXekveEEP
 lQCCg9dU0vbIG+aVmp/Kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yzGP26p5vys=;ZzCkxTZWDhy9WKmQSw8TJ8pBZo5
 oEHmOljvcgbDlbw82twaYZNleTMTTVvXGjtf3f1isfKSkUonHUQuB9Un27I/6TgfmNjlZ47Gu
 xVNvJkq8eSuCTqvVQFnarFRAbZjCz5Y98CwT+CywL96By0uXcY4VQoWSakmWdxJ94vr5T1QLl
 qBJ/C8N6OowNuFyF/Fk0dFM1GTSB5ezBSGZyh31tSDhJoMR7cDDUz9DpHFRK5bgW7Ev57Gr2A
 BoD/me6G452Apev6Y/JNi03QfD+hm7uKzx5akGOX6Yh1/5Ol7OVM33rAwJzxSaVpO2tuZ4ZlM
 4qp1x6q0jUuY2rXf/WlTMVhiRpWkqxUoKJgGClqyzZuRz1SzGUgyGa2fzH5xkXsDdop5e1Q4X
 0lFscv8NDOKsG6PAL7u7byFd9vcYXpPKw1mg681kSIC5RBFFeHn2t7xE/i8Du+a9ldbA54CJa
 c7LpiS1Su4rCpb8F2lFTxlsRU2H0/VHyYkxQqjdsqCUARDejki9s+oalG/iUQpS0S5trB1qS4
 lhkDL3SaorBEXEbT7Aze38xBmgnEiYcU+B1vIHl/KNugiv4ZqaXKFrfDbpzq2QVhnRyQ0gxr9
 Ld1atoY9ckud6fiwd/ffu9x8MMiXbsvpxLgo1Xq1rkh/42xLxvvi2xK1EJ5u6tlFZ0/ohh8UC
 cuFOCI+bJheiLbLoanLi7WVIu1LW4HjQZmgFnKCmi4b0BReihSfWfWRoF2FKc4D3+4/VPQsFa
 0uTnYJ6uOLwuIWtbMlGR2HWkoLvlO927ICgJB2na+GEO8tIx6N51HsVxEdnVeZl3AqN3+HnSi
 WtYL9ggetjteGL+mC7D7oPwIuMwEc3s7JfvIMI9kdyl8gpL5ldLpg43igDGuzuMWQ1+l+LwcV
 SxVDm97zYohOdV3oU7u6oRqrAoku/Pom9Wh+/RbEk713hYTMxN0bXxLt/EQLvNWV9R/mqj1vC
 RnsxQq1vU6FDf9VvHyK+s+54vuWlmBkuwcNFsuyG8ZncFITtUWw0XXHPIRXJ08x7tDGUgsWeb
 W32Sod4RC7ErhFPqpainmdBaLFZ7UgU1iu3msTYHPMt8/8SqVlC8tiJXRNY8sodvGOylSoMP4
 KeBkOOmx1VOoXeUBgaf9oy6KZhnaZ9HJSxa7Csj2s57hR54o2KLmyYMtmQbo9/SkL7kITkJ4Z
 sh5QsxNBYUuYq6MXjOhgYYSmBUtsMvKs3NRllCjR3KTQIRIESfJ8eZjZfQ7RYlO3NmYp0CdAL
 6uur2QFo1p5ptMlkZ9tnIGrbBdYc8U5s4W1GSDSSVa9Sl0oW8ad6m5jPfAo3YvF4JaxRkBf9/
 tAdPIsUcGY7sT9puPTXmSKPipCwLS4jm+URev4QuBoRDd4ZrheIRCnxaBi9yFpxkdAy/n+HnJ
 NIDeZgmdkMkMO10heNokf1E+PviNTN6HovBBb26EeVjemRs8lhYyvU80TenTTd2Z87qUs1fak
 hTBrqAreYusIIhwME4qkWHxnXmVxx/XvomF+/4AvNwRNT6SGMzZRjmruXXWiR1GkeHA9NrQMJ
 32H4EnXS1EvMGRtX8X5wiFSRP9b7kL4L0TSLmMe1nOD4NffrHq1slTrFDXErEdkdoqOXFSYGm
 o1T8JeF99e8v8cx0km0zuJ1ed8IIb384XxV/s/FQSC8NV08VBnQ8hikHRe0Kpco+Kpj5o6ZSv
 j/J2gYsApooebmP7pJzPYTP3u58HTTMBq+rIRAmfmUEwQjnWQSyRQjkZSFbRMclSnioDNdssf
 HuUrJUmKqwWOn2EJP9PaYNvjWarkg4QtSFsw1dxB5+ZXze5AN9SJmfUESa5NGz7r5t4VrH2i5
 IUmZ1H5hSyoVEM/WehBQ+e/OnOb3/ETinmHHbUyzerl06mO8llOw9fL4Uh4kocP+50UZ761Tg
 YNxO0j+PtQY8HbHiSMHSLj6gguCbkaHTDLW7uZ3UNeyk4ZlCjIXCjumiADF+q3vSYzRire1jy
 bxlnUIyz03sUZKti5l6YYuHiyuItq+g7XrRBNp+GJwBCZ9yY2+aibC7WJQNjJqT2guVzw7S8q
 iS4D4afhrBax5ktlr8m208JFyFw5Tanme0r2H41lW7lPH6s0q1JiyeXNAde7H4txcYL6I8Q6m
 Cs1zy8Y4IFSskHhkvvdK8KQc4xbr6eZCJK4b+c0ZJZyntAp7RJyXUOthbs3eISoWhNYDipOfa
 paM8FRxspAYTSCqmmWqbrWF8bidRcQ71XNOs+osjNaLjZqdRlmuSOi4jar6zIajJ5BUq0z/YK
 RCPxQus328jSyNh81kUZBOesNZj+65ZodbWpZwQNKsymTMXZYXNmOIQrBwcLyVVIqNgr3RCs/
 JucY6R5DwoXUlKhqqggofeKOjGNMGE4acdac9dUymV9rImRgGO9aKYP/AFxo9wNuidmLvTxsm
 LqDzSQHdX/QYUwd/9IE5bM6MtUBJi2+h+letteVsBrpT6Vlf5ef+amd459U/XgB4QqzwoAt17
 h1TWF8yCWrZzymcZwK+DWDf17HdroITcGjLkrA/qFYFrnHdzIBhcOQR2UBACGbggfp3GqnbO0
 SQggfrTVV5KqmcxJ4Kh5o2/ORNKX3HN2b9Og/uLnxCcfNvpyUO2pW9kifVWZsT3bCZ00dhsFE
 hEUk7G1TK03BBITOc5wxqEDM+dhx1pkfcuLdqMHxbWkoUerDP2LAOqCyL4X7W+olyRWMPjRbO
 EVSnaDo9mOVBA4OsFlImc7EXQadcE6f9lQHya2/VNmox4ZW296/gR4m35RKA7WatDzE3tiwVM
 osKBjbTL874zVIHlZu08oqS6yowbuSl2kqxaEGGLDHvM0W2DY0cwsYekdEUqQKh4Lfyj/8KWg
 TQtWF61t4eDH9uMu/U9J6J9vRJkYZzCONZs8xuPvQs2GkcOBicsXVzvp0DUHdEpcXFcJ6OBOA
 jDrwU28eUhzC0UrqaDLoAusyz4ggsiZ06zw9on3I48vfAxAxpZh5ngRRZinrb/2LORp6Vfd0p
 3hS9D7cuDWOilQvvZJCL2EL2H+EqQ7vnH6doa6URQOPNsuh5yJI3EGJmfRJRRNO/Po03rAFCY
 hDNSAtIEWTIadhSkyctdtbnyHyq9AanKziUJ6RS6HCGueUeWlooxEaNjvGzVtJqbNCf3VpcHC
 kf5MKelbtqbh+brJO/rxFq6yDVBXnBKOedjs0e4fpMV2CkqcNkYMncHZbPuR06/gCNb7sNY+V
 arCkb6TO8eYujCspLVfFydVDq90VVij17I/n+XgZDTrdpko+5UeRt4obQdny01WSFKb2EO4IM
 B7N5JEOfI7VNoN6KpgBJ+noazsjB4ZnY7zEDUQSU2ttuik+PUIutMjFiuosaUGIMBGNLspcHP
 oKSFrTuQZSpNvEs4G3dOfZ5/D/JzGXFiAFD9bugQrQLfsENJuP2OT0SvWt2SuW+dDkAsPkD8v
 JkFQOpGAuHtBzG0gkJZxdzNWQgE0uyUj2RfZo5jwxy1RPjgcMEcEgOq62MizOtixZEm2woEJ/
 lWrhw0GdGwlz8eoicP5vXEgmaqYxAhXuQzZRpIOSGMYX39rK/g82QXOvObIMlhWRiRAGITmkn
 rjDBXqx99pwMKFQ8hIj/z+2/HoxtY95tajnjH5mVvI97u2+12jRDeKa37uAGVGqCKVjb+swwT
 b3PjHWaLD+NTHeIS8ZBfQM55BBZX+DLQsXBHJTUc/s+yY7+CcrEMtK5OzJiYznu8MDk5KbOzL
 yZ7ZKh4B8p0aI7VMOZgFnBbBdLOrjeUqjpi75yAGyc383DK2dpK/jF/rNcAYO8/57G0UiSaF0
 s463vKV4y0wYpRA8sZ9muNJMgzPZY2pisVgCJleE5tmXTj6gGYDLPihcehhA9MukN6GC+aTkb
 dsUqtC7xDCs6WQrIWro2eNQ1tq23Z3U6yqZFPZMDXGbnxYDrDPKGeqkq/OBViLHEdawc2gEBr
 +i9dwPsLqy0wZ6uh6lDKlmYPYyrwRa1g4QBQEj870RP0nDjzhbnCrmEvpLKFxl35NPD514LkE
 L7TvBAUF7QmbY46mrQRFouF79qsopLUHcBDYohsKoMf3rgK0FUnXiHJaGP6334Jm0n224hq9h
 WQwtDQrFfvnxVz0XQMNDe2WZuMzFQGnjZOcZvzlU/HLMudOa2A2RpJ1OjhnpAai8E8S1MQ5Ln
 XdCuHgouB51zT37sVYLSR+sERiYuWAEq02j00iHk75Djci+rhzH6eXaXwNB0ueZw6BoLoNYNy
 FLS+YdiEI0/MOWoMu7m+vB8v+nYfBEAOGCwnlb/6RRyQ81wfu7cNoOBUnfbImaV9gtFm9B/jX
 1hqBVm4KnPPk/F7rh55OXk5K5YCBLjRjmqstXiCIKhKtWH2mcfkc07HPnyUszeUr5hBVuLegH
 /a8S8Xzh74B9ZsW95EHdc7rz5sw5nPBJ0bI3DX5vYNzSq7aW7oz1fuyHatt9zNw0ocraLDCGM
 QmCwfuqrptWECd9G3sVAOCDdz+Vchw6s9TE8u/ZneoZmpYs7nAGzF+QtbuHnstFuwc3UWZpUd
 qHoVvTKR8wj9yIOek+R19e4bp1yY9FJbQxctoIFbgYWQdgeT6ZWcGNMxHUdvRoy/Y4YWPUFHj
 fxNn2r6ZvPmrn98B44vKcQZTRPS+EMyHH7T9dUd8J0jb6SV56Gr7/aPalaAabPKJe97VFnRdd
 fVs63AnITL3XZhVBR7Jvm50SnD++cVJK5Cz4Dnc8yEI00HEgK3BJ6dnZ3BWI/pv+ZI1EYQJh4
 dczXBTyysfM7Bvyy6vKqMF85aVk4u3fqUlt9WawWssw+qrF1Ng==

=E2=80=A6
> So we change the detection of missing bq27000 battery to simply set
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc2#n94

Regards,
Markus

