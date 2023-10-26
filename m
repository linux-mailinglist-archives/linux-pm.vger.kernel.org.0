Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907587D7DC7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjJZHoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjJZHoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 03:44:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8172186
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 00:44:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c77449a6daso4775915ad.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698306257; x=1698911057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g17+UKBmkyZS9wbO/x2xMlBYlJ1SR61KcBnyZgFGI3I=;
        b=xAm13pfc0zkOMpjOvUPlXvJ3B9M76bVTWn/rgGl9U5GreqEfhuOAd4anAnoWjm4Eed
         A3Aoc9hgE3h45eSyFIMFNFM/DmPEvLerNer+0lPHRqMF6eYMwcBeA0CRgPS8B/4X8Hpj
         OUrpuSs1gXKHlRzJQgxWVF8152LGOLlu4f2fG2pwNaTBxvVMj8Rn9puTWPtI9Ha1jHfy
         zisBKvF9UL6fknSGR9U1RUTMPbZWXo7hJDidk8vLuC3oIrPFI7Tvh0ZZFYYPIXm+33ey
         Fvxf8TPrl0B5oxAnyLeh9+Xek8ejjqqHLJdz/iacVg1TQZpq/xWbUXxbH3sBnKyF4heh
         bkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698306257; x=1698911057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g17+UKBmkyZS9wbO/x2xMlBYlJ1SR61KcBnyZgFGI3I=;
        b=vbYf79uVwCV9hEjmH0+3HipuFX8WzG3vIOaEU4Whc+eF57fEmuuuApUAtf8cz1m0i7
         hr0g5ohcoah8kSKnly352zX85NDRBiP51/b8uxDTHklD+6/53NlcLUfCp8fWDN32eGAW
         eEIknGnLcJfi1FiDtmy0FjOP5OCQt4XGBH9MXlap5grzyPBmzUZS7O6Bqh//v34tcZxW
         eeBa5p/PfefjsP9yu+7GQBGwkX7PUkQRkeFPEjHfb/nFx9Nq7OumG1EtS4UOeeYkemkh
         kwmNZYAENvaA0t8rtYZxlKStB+zXYiqzjArBNkTyAKLS6n2SwLlz0ZU8SK7vOEOMwvTx
         BaMA==
X-Gm-Message-State: AOJu0YxZDNudQWgYp6XBEJy6cJ76Mlsl/7IADINxMJyEj/sphyqkptdV
        x4r/tbq+xzeztaGyJQMsWCE8eA==
X-Google-Smtp-Source: AGHT+IFUMWUZuZNwnxUuhicnj3A4C6NR4njLTymDIpxSY0bkrWiQocJ5k71tgiohyUz7RlKYYeNGAg==
X-Received: by 2002:a17:902:e551:b0:1c9:d358:b3cd with SMTP id n17-20020a170902e55100b001c9d358b3cdmr21838046plf.42.1698306257209;
        Thu, 26 Oct 2023 00:44:17 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b001c71ec1866fsm10336964plx.258.2023.10.26.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:44:16 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:14:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
Message-ID: <20231026074414.xju4jqi2736d3brp@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
 <ZTeoGiMQZ-OoYJBG@kernkonzept.com>
 <20231025073634.4et5epfog25o2pxf@vireshk-i7>
 <ZTkHVVq61lrpRUOv@gerhold.net>
 <20231025152000.vt42gvti2e4rewwc@vireshk-i7>
 <CAPDyKFrEdHGVeKo0oh0f2uJjtASbg4eye2UbEaE8s3sy+2tWDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrEdHGVeKo0oh0f2uJjtASbg4eye2UbEaE8s3sy+2tWDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-23, 18:03, Ulf Hansson wrote:
> I don't think my patch broke it, I just followed the similar semantics
> of how we treated the OPPs for the required opps.

Yes, your commit didn't break it as it didn't touch the required-opps part. So
it is my commit that moved over to the generic solution that breaks it.

> Are you sending a patch?

Yes.

-- 
viresh
