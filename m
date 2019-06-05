Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F135AA6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFEKtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:49:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:37749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfFEKtj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559731760;
        bh=v/j4Z2eD2GD0zhfPgdWBU+2pAksyhmUHHesaJHOcPaE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZHiWZLHHyxs88AT8AMdw01q3xTaXgiAve8Y2VyJolxMQ9Wab/woTcgutxaXQ9rydX
         R5atdDl5Q6WImQ8mjSTLSGwxSjXd/aLjkT/4EHQslHbc2ksCXeQD9/opLGZBRrNwj+
         XD6WOUExB2+WBhkZgM9AFzRx9/zdwVC7eJcc9m2w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhhwJ-1hBhZU3L4V-00MtYC; Wed, 05
 Jun 2019 12:49:19 +0200
Subject: Re: [PATCH 1/4] clk: bcm2835: remove pllb
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
 <20190604173223.4229-2-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <b597c584-76a6-d681-512b-da46306f567c@gmx.net>
Date:   Wed, 5 Jun 2019 12:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604173223.4229-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:q8hji9dsXrh1VvUv+Ij0VE8pGv10bixoURYgbVqiiyW6VNg1c3H
 uzsDyRSLniYuAR79+VWAGy3LAZ6TxbkjdbMIVBCR72yyzT4LmXgYetMVMzshusahVERQ/G/
 GNCzfEdHdKAqyT84AfMp49VTuGtWbw1x0mB0DQoPcPloIN0hzbqOqGDdd8XMcbkA5CVbCYy
 neVdpYuk6bP2BuD/kpG5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q/sl8JaOVvU=:XZ0LNFl/HcVox4CcPVZBtn
 oncvuIZLNyw6OVvwgAaL7yKjeOOTz7+hOcFhhqfbIjCU8tVZhkNatbOZ6IoGgC3AZm4rEAJ8d
 bYD5v/lXmPk/RLQVdN+FeWIgjyhVupsWYoUdazFjYzygYpToKWUsGI6gGoZHTcqDNGfr4gwYi
 v+pvRR/FDN1HXD84TtKKlSCsm7T5fVBNPoe/VqwD8wVEEthM6fOi6CTAb/vJ6rltJ7L3jvztK
 Z7roAs4ZjsfzzqjMIw13xwuQgAzeDG36VuW6tAUpSevh7PCT9pQBM0cgYZjqR1vGOVwDxqB/u
 vvu0Wvg2sJHSk8l4n3eGpkbL1ZYY78A/+xid7ECTWfnAtyboluVJxB13R1EkRx2C0U8Rfkiii
 PA7By/H6LdQymoRJIBZMxlTKEN8cPKh4HviYHzPbPwBgsPjovnSQtDPWPsxfy682DcL+96/a2
 uOyjlPPU1NtDzvZsbJlthbDqjiAinxLOYZbqLLZJa3OdtSGE2hrT1nWzWgG9cQnwbIXZZ8GY2
 hydmKeAO9XfMGyzWRFkuMSicxKlj4SXV5lvkxbGsuck6wg9piexaEmhuUexm5kKzilhd6zkJb
 gOOSBahC5NcVPemuDSrX28iYaZ7ImBY385Jk3OkoAR+PomvZfrrTcmpNIcUFgU8H/LnypX+fy
 zYdSK0fIEkJ2wfUWDs4p+YFWq/lV22d+RBu4zskSSx79HaeQmdDp1HtAQ4cUIl/qBpRna7xuV
 EqbylGUNEJ2Nw+1medUtMH1L4zSI98qJphLTkwBNPOLPylOHekYfVVVDNfIndwL6xHx1l/MRg
 W0FyCtJF+U7hvMwN7GhBhai60PSpmWH8kG3GmGCoESQwNfbsJoMgXIzlV87MHMCxdo+YbcURp
 7F+SLdhWad0CcwOvcdi2ypAi8UM7WszHogSEJB1B++++DPGVV2QVOvze/gm7ppQ3TBg+C0S0M
 9+p6cmVLNpSKWeUbUZSDpzOmL5hwTIEka6PeOj9V5t8ShFr7mYD1XYKMMwzpjWh1cJYhiuIvx
 yw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
> Raspberry Pi's firmware controls this pll, we should use the firmware
> interface to access it.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835=
.c
> index 770bb01f523e..ccb0319fc2e9 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1651,31 +1651,6 @@ static const struct bcm2835_clk_desc clk_desc_arr=
ay[] =3D {
>  		.fixed_divider =3D 1,
>  		.flags =3D CLK_SET_RATE_PARENT),
>
> -	/* PLLB is used for the ARM's clock. */
How about leaving a short comment, that these clocks are now handled by
a different driver?
