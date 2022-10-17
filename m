Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C93600B0B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJQJit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 05:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJQJif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 05:38:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98071C90A
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 02:38:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h13so10571168pfr.7
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYiqVPZIS1J1dpwq4iLF3yMMBbSMfrZKPkp+8pKZlRU=;
        b=C7Sk+yj8O8RpRLsalwCKu+xIV99YpUbA+yXzavP4zR1cI/wF1xP9IuKtjnyLATmnFH
         /poJO5RnM/CnMFkKxGqC4J7PGgvqqMKApoon0xbW/CcvBsX2K7ZNoVkieK+VEaROCJme
         wsEm6qVW3SRi4/UC4PGByi/jg7Dh7L0XvXj1GJ/OImdP5H+ahq4OyYRAogjRQW9O21GY
         ug7llRzsuyNvPAAP53iCMLU7pGe9/ndFiC0Jun8fIFyWfnnkaB3MeGIZ4RcBbC4j+qSS
         5E6VQtKak0Uic0f9Bo24j0QRe9mVAfh34mnDXITomWnT7DbZXqaYr0vGLwC2wVXG/aAt
         kM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYiqVPZIS1J1dpwq4iLF3yMMBbSMfrZKPkp+8pKZlRU=;
        b=0/tyjugI61PikYm1Fzx+w66irB8H4NSzzOKIWWug++Q3zCgrVfN4CZ+hiQuzDyCRln
         RyTejR13tvTOn4eq0d7K/bCZVKzhnUs9okIe0vFpsLH/IlqmeNwOG0x7SFVCOT1ik07r
         ClL7MEuRlQ0jLH3YlAQiODMiN3glqUn1FVFe+IJ7s+lNveLzMHBe2zgfkC6wF8NjU6lm
         rWHFwHGEfmbhy/5kC7unXnrXhPkKAN8TnQhXpitiaqv6+AdEF7v/3NV9KKyF3g2HMc7t
         wU7c8Ur4UbiGE8xTgvJpnpmvXj5szy2HhVID+1vke+SRo8SdQPajmcYDYWZdQezzxuFX
         6x1g==
X-Gm-Message-State: ACrzQf1N/h+YKpvzmT9loHurg4eX3vuRGxRwU7aio6d5wweHbBDKylsC
        3Z//WjjEVJzBEFc7cNu+AzISPA==
X-Google-Smtp-Source: AMsMyM6KEmexlluJ7FQ0qcnQuAZG/rbMBLwc+VIBjAc9/1JftEpWUqEKkpAsr6MPW1qkW5DKgG9Skg==
X-Received: by 2002:aa7:8d57:0:b0:562:b63c:c2ba with SMTP id s23-20020aa78d57000000b00562b63cc2bamr11817616pfe.29.1665999511632;
        Mon, 17 Oct 2022 02:38:31 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id c21-20020a63da15000000b00439c6a4e1ccsm5759446pgh.62.2022.10.17.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:38:31 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:08:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <20221017093829.h2yiawwpffn67qme@vireshk-i7>
References: <Y0ltRJRjO7AkawvE@kili>
 <Y0lylQhiGdVGTM1I@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0lylQhiGdVGTM1I@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-10-22, 17:30, Dan Carpenter wrote:
> (There are some drivers which might cap new_state.  I only looked at
> tc654_set_cur_state() and it doesn't cap the value.  It's always going
> to be safer to do the bounds checking in a central place).

I agree that it is better to do it at central place.

But, tc654_set_cur_state() seems to be doing it just fine:

static int tc654_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
{
	struct tc654_data *data = tc654_update_client(cdev->devdata);

	if (IS_ERR(data))
		return PTR_ERR(data);

	return _set_pwm(data, clamp_val(state, 0, TC654_MAX_COOLING_STATE));
}

-- 
viresh
