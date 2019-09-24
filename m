Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21221BCBB6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfIXPob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 11:44:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37968 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbfIXPob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 11:44:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so1609099pfe.5
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRqhU1AihYJ2QqMEDa4hoNnJ00l/92NY2n3WTvQE51k=;
        b=N59VSQNOtKoruFGih+9OfLHlJDZghgi0SHzvbDJnCjmSJNCbKIz4xT3qDUWkkpVZuO
         ur7WnjtgGzFrGmmpJRPHZwLXT4NhVxGKX3IkxFpKapUI/PEIpDJaXgVZz4Px4iE8fDDh
         dOcpxkfz0wQxC/P5g5kJaBwjLMrBhJMwany9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRqhU1AihYJ2QqMEDa4hoNnJ00l/92NY2n3WTvQE51k=;
        b=mI14TW3d0iyclEBL64m6hZJPsUy+OgtLPWvFZcmUScoH6UrxKlILiIQvWP/LMgBuV0
         8titeiQ+iX2zS3HhcJ3YbKdonaJAdzG0IqC1Apli/vGFsPM3CUNWJ6qBf0Mj86X/3bru
         xvdt3icrnDI2CI6Y3JJGJGGcsthSZui+VbR0R2zdS7iDtlP8oQlYQGFx39lA6LPHm5dq
         58PAqr6Pxd1oK8Ei9xtBZVmtSnCICFhGrLS/Ky/N3OfDeKeev259dx2zB6Ani5bAM7dr
         /6+gkIkgvXNcE2ttgY/qi7HJr7BnknFgHBBL6GsGirERNoi4pBiMRgPzTZ1eu+ZK6PCG
         iHPg==
X-Gm-Message-State: APjAAAU6m1meuYN9exiKFI+ehDl6X2vjwrBJIoCGElbgz2gPpXvy+LtX
        tdENBHde78fvBY9lL6VoZ3JL5YeBdJk=
X-Google-Smtp-Source: APXvYqyy/dekHqlB0kdPWKwq8sUxNkiNic4QkQj9ZSqM6+zm9tsd2AmEmoeo9mAVn3VjMCVJaICECQ==
X-Received: by 2002:a63:531d:: with SMTP id h29mr3906627pgb.52.1569339868740;
        Tue, 24 Sep 2019 08:44:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q13sm321184pjq.0.2019.09.24.08.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:44:26 -0700 (PDT)
Date:   Tue, 24 Sep 2019 08:44:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PM / devfreq: Lock devfreq in trans_stat_show
Message-ID: <20190924154424.GI133864@google.com>
References: <CGME20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648@epcas3p2.samsung.com>
 <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
 <979d107f-0a52-3aa4-a397-acb0ff754a3c@samsung.com>
 <VI1PR04MB7023BF1AD2C61C8A5ABAD5FEEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023BF1AD2C61C8A5ABAD5FEEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 24, 2019 at 07:44:16AM +0000, Leonard Crestez wrote:
> On 2019-09-24 5:07 AM, Chanwoo Choi wrote:

> >> @@ -1507,16 +1508,22 @@ static ssize_t trans_stat_show(struct device *dev,
> >>   	struct devfreq *devfreq = to_devfreq(dev);
> >>   	ssize_t len;
> >>   	int i, j;
> >>   	unsigned int max_state = devfreq->profile->max_state;
> >>   
> >> -	if (!devfreq->stop_polling &&
> >> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> >> -		return 0;
> >>   	if (max_state == 0)
> >>   		return sprintf(buf, "Not Supported.\n");
> >>   
> >> +	/* lock and update */
> > 
> > It is not necessary. Anyone can know that this code is related to mutex lock/unlock.
> 
> OK. You're the second person to mention this but it's quite strange to 
> see objections raised against comments.

Comments are great if they add value, in this case the comment is
stating the obvious, which IMO just adds noise to the code.

The coding style guidelines also briefly touch this topic:

  8) Commenting
  -------------

  Comments are good, but there is also a danger of over-commenting.

Documentation/process/coding-style.rst
