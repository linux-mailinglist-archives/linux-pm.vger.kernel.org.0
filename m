Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F431322D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBHMVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 07:21:55 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:52253 "EHLO
        4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhBHMUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 07:20:12 -0500
X-Greylist: delayed 12024 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2021 07:20:07 EST
Received: from player737.ha.ovh.net (unknown [10.108.20.107])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id CF72F1FBA7F
        for <linux-pm@vger.kernel.org>; Mon,  8 Feb 2021 09:42:37 +0100 (CET)
Received: from RCM-web9.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id 42C2F115B410D;
        Mon,  8 Feb 2021 08:42:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 08 Feb 2021 09:42:28 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify BROADCOM PMB (POWER MANAGEMENT BUS)
 DRIVER
In-Reply-To: <20210208071619.3234-1-lukas.bulwahn@gmail.com>
References: <20210208071619.3234-1-lukas.bulwahn@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <883902e16721c9a439a7caaa897a317b@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17977525290287992534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrhedvgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhgpofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjeffudffgfejgfdvieegudekffefveehjeeuieekheduieduhedvieefudetheeinecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-02-08 08:16, Lukas Bulwahn wrote:
> Commit 8bcac4011ebe ("soc: bcm: add PM driver for Broadcom's PMB") 
> includes
> a new MAINTAINERS section BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER 
> with
> 'drivers/soc/bcm/bcm-pmb.c', but the file was actually added at
> 'drivers/soc/bcm/bcm63xx/bcm-pmb.c'.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches  F:    drivers/soc/bcm/bcm-pmb.c
> 
> Point the file entry to the right location.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks!

Acked-by: Rafał Miłecki <rafal@milecki.pl>
