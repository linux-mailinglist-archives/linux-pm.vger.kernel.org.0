Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46975602308
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 06:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJRECj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 00:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJRECi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 00:02:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1D186EE
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 21:02:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p14so12970111pfq.5
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 21:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwAQvtMI1M75+m0ehBHi8zsfRKkhuP4P/EhXLq39nFY=;
        b=HyW7uJqyUn/nFt++NYHpp2emFix4zkJT2Kul7Tlk+b3+EFIM2agpvIEkdNf/gEQyLn
         knYroCDpre0A9aSqfQNDneMsjj0fr7QRzs291Og6Il/Csf/PA2hI1R+VO/U5bCFBTnd6
         ZySeTp/83FOnsJOL0IBJsl7ClXpXVWnmT/SuK+JFzr2PQjqj7snOXMVBg9UoPXWp4W/Z
         +m54UtbqNGEocmmxviq5USFVlIVHa59TMH6jYn5dXzkNVdW+CFVa4R0d9WaccnZwDhAR
         eqTB0FCo2HZJkB2Y0kEV4tdmCJGl8vSw72/jnHMTugNtK/NQDaBhVwgekDUGBgntLtjH
         80BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwAQvtMI1M75+m0ehBHi8zsfRKkhuP4P/EhXLq39nFY=;
        b=ynMUduiqlhj3qATOPoKBocfbToc74kMGCPKGvedo0hipYO+jPik8MTKfbKnh0cMOz0
         Vd6qr961ndW4uVQGjdJamq8ibGEbYNVggFGU8+jc4UGiXryrOx4oPpgyfPwSVi3Posqd
         tNul57oLCIjuRL2EbaaCAYtODTOA39s+Q2Gug+QaHxYg1leCQAUNTGMYw5GDhb8gy1eL
         L0ABcMeDvNnnMkV48+edwKGVNfmgtFNYWy0xYVLKBB+OHh70hucU8yLQxirfPlkZR1+G
         mC+rlZVVnXec2uouvhVJ6Kj2nk7q2/VBsJq+uaApI4w2AgTuQp0Th2CN4kZkdpYqL4K+
         0i2Q==
X-Gm-Message-State: ACrzQf03lbOyr5VvV1XvB51AVyfeuRjdwC6QF7tUGTM0thP2JMKOBgUh
        pAQO+O1jnkrv1zVue7xwgkGs7Q==
X-Google-Smtp-Source: AMsMyM4OdeAq+IuP63E4BuxYQMsniV0twTqeL0tcPFnsc81N6GAOzH5pPcSB1sgRiBm4sqNtQvmGKw==
X-Received: by 2002:a65:49c9:0:b0:462:9ce1:3f58 with SMTP id t9-20020a6549c9000000b004629ce13f58mr1005090pgs.200.1666065755275;
        Mon, 17 Oct 2022 21:02:35 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709026e0f00b00176683cde9bsm7390620plk.294.2022.10.17.21.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:02:34 -0700 (PDT)
Date:   Tue, 18 Oct 2022 09:32:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <20221018040232.jjl7bihlel7uxdds@vireshk-i7>
References: <Y0ltRJRjO7AkawvE@kili>
 <Y0lylQhiGdVGTM1I@kadam>
 <20221017093829.h2yiawwpffn67qme@vireshk-i7>
 <Y01WbMOnqnA0riM4@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y01WbMOnqnA0riM4@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-22, 16:19, Dan Carpenter wrote:
> On Mon, Oct 17, 2022 at 03:08:29PM +0530, Viresh Kumar wrote:
> > On 14-10-22, 17:30, Dan Carpenter wrote:
> > > (There are some drivers which might cap new_state.  I only looked at
> > > tc654_set_cur_state() and it doesn't cap the value.  It's always going
> > > to be safer to do the bounds checking in a central place).
> > 
> > I agree that it is better to do it at central place.
> > 
> > But, tc654_set_cur_state() seems to be doing it just fine:
> > 
> > static int tc654_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
> > {
> > 	struct tc654_data *data = tc654_update_client(cdev->devdata);
> > 
> > 	if (IS_ERR(data))
> > 		return PTR_ERR(data);
> > 
> > 	return _set_pwm(data, clamp_val(state, 0, TC654_MAX_COOLING_STATE));
> 
> Ideally it would return -EINVAL for invalid state values instead of
> clamping it to a valid range.
> 
> I feel like -EINVAL is generally a better API.  But also if we're
> relying it to check and return an error code then obviously that's not
> what it does.

Right. Hope the patches I sent fixes this, can you have a look at them
too ?

-- 
viresh
