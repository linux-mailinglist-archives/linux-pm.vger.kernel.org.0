Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F870BBBD4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 20:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfIWSuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 14:50:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfIWSuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 14:50:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id y35so2704479pgl.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFEreeiuCWUIubUDu2nto0CXXCx0l8DJdtGf7sQk5hI=;
        b=PC+bmEyewuG+cCx1WrX3c9poig072MLtq/y1UcRcWcBXMSKhoY0i5IiADx21Q9ZQiI
         ucpQftg/fj56BCAHbQjurIeU5lwudfMoc8oN+4M4HGsrMOUnW/vcJcu+rOTvaI6E/Xce
         YLmVdHUNPoxYwHaMxhb/IQGLNj2dQkNbhBkjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFEreeiuCWUIubUDu2nto0CXXCx0l8DJdtGf7sQk5hI=;
        b=APnCwJjaTNfWVue6/o5bn59pR6BKxngH9lANCDzbctolZfHxjrk4nAdKHW2i49HNuz
         YuaKtbxYNooiTPtmptJhgz4X1yNXC42g+nbZfzGcAqxUuwu7gD50WkDRY/CiJB9huTeN
         LoS5NAcpw5+Cslvca5VfBzfrRPBDjgBshVP21zym0CxnLZXOjtmAFZF+F2bDw8DHTMun
         pyEShhC+vo2VyMmpMvAxkY4gVuqyDHhHv5REgwesGkQ9fgmdrNf0zwEWHyHICTcZznlp
         lFIo2X6sdtY9PfGRTJlwdmn/N9MQwRd4ug4drKxGyQKsOi4Rud3Q6wfIzT/3qhxMdJDk
         hZvg==
X-Gm-Message-State: APjAAAWAkBjTaLrMTsKNboWYEHiTUhpBzaYCzsD6IAd53xiJsYkxCU5c
        jCgIH16cljHA2N6dBO9jKNVtJQ==
X-Google-Smtp-Source: APXvYqwtX/NH+k4fVe4nAuqpRJwbGGrTrWKGRhBCpwxl3cOXJkcFUpjjDRPZQlN/cssPs2EU87T9hw==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr1024129pjn.10.1569264650065;
        Mon, 23 Sep 2019 11:50:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h6sm17603497pfg.123.2019.09.23.11.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:50:49 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:50:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PM / devfreq: Check NULL governor in
 available_governors_show
Message-ID: <20190923185047.GC133864@google.com>
References: <96f459015e6418cee4fa20fdbdb80c4caf417c19.1569256298.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96f459015e6418cee4fa20fdbdb80c4caf417c19.1569256298.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 07:34:43PM +0300, Leonard Crestez wrote:
> The governor is initialized after sysfs attributes become visible so in
> theory the governor field can be NULL here.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Found this by hacking device core to call attribute "show" functions
> from inside device_add.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 00fc23fea5b2..896fb2312f2f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1322,11 +1322,11 @@ static ssize_t available_governors_show(struct device *d,
>  
>  	/*
>  	 * The devfreq with immutable governor (e.g., passive) shows
>  	 * only own governor.
>  	 */
> -	if (df->governor->immutable) {
> +	if (df->governor && df->governor->immutable) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
>  				  "%s ", df->governor_name);
>  	/*
>  	 * The devfreq device shows the registered governor except for
>  	 * immutable governors such as passive governor .

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
