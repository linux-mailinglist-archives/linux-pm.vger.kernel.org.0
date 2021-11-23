Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4EF45A608
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhKWOvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhKWOvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 09:51:54 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E092C061574;
        Tue, 23 Nov 2021 06:48:46 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id be32so45016556oib.11;
        Tue, 23 Nov 2021 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UlWg3b9zRf3wDB2eyuOSX99byNHXxk1/8bCZdPmS5y4=;
        b=n1xDZq7+b3UCAPXgtauZnz6z5tTynvLmRLEt0Do/WDKpBdPNGCMmFmtNhUeKqn0dm8
         HfizfkeAoGaugEOdWWgs0qfPANEIvwRva98BjIJa3W6l6b/ZzLbKbDpzNP5elmYnQJig
         83GMxMXPhBzw+gRwb0Ckd6zWLnKh2eKfk8PIYcXxKpHbh0097SkQSJQCl3asU1FYIsmp
         r2citD9vVaI9g1pW/Ch2SG00accjoeiCfX4ovC/qU+opfDVdhCYpB9cJZML2vC1SfdgV
         V4cFmx1pF9nzv3552JHMEXFCuAeJ4btEevSpw45U9e9MPMt9gui3ZLdkdysi3S5yCC4C
         rdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UlWg3b9zRf3wDB2eyuOSX99byNHXxk1/8bCZdPmS5y4=;
        b=mRg+5vj4Ghn996YYC7OVyTJ99Vg6D7jYyDOz1ItknWGjQIdQsrDKEL6UuVZzEntr6p
         U8WZxENTgiXPIanS5ZcIzcangjmDrsr6CkT8my/LvEY3Fi3BtCvCnXl+zdF06UmzIscJ
         UNwdI0lCVv4eJVeqYGxrYxK3ryMzEgmugcuknESbjbsf1PUMVm2BoKtFrVzdYeq4V71i
         5Rc066dm7TCPuPRaUrwSYs/TsHRIVl20evQW0dbu57+gyFsnE7IBrc29kBZ33a71GC0S
         Wgqz/IWXKtrQjYGn+7ETwl4Jz2OJ6F/oa0XMY1Gtl2depvNcii6V72PIw8TAguIZCxa6
         YqlQ==
X-Gm-Message-State: AOAM530HmIYNb47HaVhy/lsLlYlTh5/FzR+n3ABqBxW8DvYZelOebI55
        NEKN0IdtTpMTjSSwPM4qvfZ3qapc1VE=
X-Google-Smtp-Source: ABdhPJwww7j9jvE98NqtIvLaN5oPmA+j59NmSeXceq2rTihk9q/VRRIpJAErXdPHh0McCDYsblI6FA==
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr2922490oib.120.1637678925372;
        Tue, 23 Nov 2021 06:48:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l23sm2219490oti.16.2021.11.23.06.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:48:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20211123083925.GA3277@kili>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a29fa1be-1df6-d43d-9a6d-90db7587af55@roeck-us.net>
Date:   Tue, 23 Nov 2021 06:48:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123083925.GA3277@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/23/21 12:43 AM, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error,
> NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
> when the CONFIG_EXTCON option is disabled.  This is very complicated for
> the callers to handle and a number of them had bugs that would lead to
> an Oops.
> 
> In real life, there are two things which prevented crashes.  First,
> error pointers would only be returned if there was bug in the caller
> where they passed a NULL "extcon_name" and none of them do that.
> Second, only two out of the eight drivers will build when CONFIG_EXTCON
> is disabled.
> 
> The normal way to write this would be to return -EPROBE_DEFER directly
> when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
> the error handling is simple and just looks like:
> 
> 	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
> 	if (IS_ERR(dev->edev))
> 		return PTR_ERR(dev->edev);
> 
> For the two drivers which can build with CONFIG_EXTCON disabled, then
> extcon_get_extcon_dev() will now return NULL which is not treated as an
> error and the probe will continue successfully.  Those two drivers are
> "typec_fusb302" and "max8997-battery".  In the original code, the
> typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
> now that function is a no-op.  For the max8997-battery driver everything
> should continue working as is.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
