Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843817A9798
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjIURZ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjIURZa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 13:25:30 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC4A5F5
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:11:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1d6b4735158so647448fac.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316275; x=1695921075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pNpVr3hX07AdKTZ8+Sx0LVisp+9RYkwStP9wMLdYrzw=;
        b=B8OVRkqoFvTp/wqKlR2eB01zyqeLt/ux2DmkWpBygorKe0l0i4vDYn+pZW2D3a/Oqu
         LGd2f36Ng9JbBB/4Xe7KjeBi6FjUvGUTdU1xrwgD36hy6cEr+HuiQPRaWGFV1fIdwLV+
         6ww11evGd8uz1qhvaJpjIKOY5euOIh6Gs8yhJuhKB/E8vC4jySkLaDfu97/6/URr0gmX
         LK7ZK6vBhhBvwI2Ly0EKMyHUqKU59MLIi6uWuZB767Ia2rEkicw3ssAa3jUyVI9GZggj
         Blx922e5otyOv6DQ0qAJ9043h9HcuAyqP/Ecq9SCGOdfC8qYPQJxpYXxXbEben/yfM5M
         +koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316275; x=1695921075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNpVr3hX07AdKTZ8+Sx0LVisp+9RYkwStP9wMLdYrzw=;
        b=LBiZ/4SDsdvUTlPBb1VraJaeXTc3i3NrPLSa/vJuPGFqoIaQi5cYYE+jFuDWxIYk7U
         lrYNpsUUXlGONCRyM/7WSI8Inow5lnNo/auiqZcuZtp+03yhPPZbpkTUXjPmZvHdGIKe
         J+m4EMHE+ru+vCFqC8I+clQ6OTUlHBU/TZFIjJ+mPr9YxI1w+ZcqJk8GcPjhzR2Exgo7
         0j/UI28VnQvZyexETXQnPLYp/oyn54Ez7YvGnehBlEBUqi7VI7w5XXLj+BqESUOMpGbj
         c0SXB6rTkiPSLwpcRjdvWOvcHy1WBQQBg8/WM5G1KSvKMaZNRUCdtSsppHsqAYbiPqcD
         tZ9w==
X-Gm-Message-State: AOJu0YzWnaMaW7+/X7F0sI7W+3UrAB66LSQ5r+DuuEeZp2HvQLMu5CMp
        cj9WZEqxIRl1mKItfOrwcxMFWPZylZpuTGl8MTZ0fJD4oeeryoTOAfY=
X-Google-Smtp-Source: AGHT+IFqX3AQtEQOsB1IQQCIx2Q35DO+VOl1a5nyQVZz96a/QlXlu7E2WC2lL+gM1UWaSurybAhPe1nEThyHesRaRIs=
X-Received: by 2002:a25:d301:0:b0:d7b:a78e:6b2d with SMTP id
 e1-20020a25d301000000b00d7ba78e6b2dmr8458738ybf.20.1695301372684; Thu, 21 Sep
 2023 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-8-ulf.hansson@linaro.org> <20230921111426.b2vp5hu7ssdtmz3n@bogus>
In-Reply-To: <20230921111426.b2vp5hu7ssdtmz3n@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:02:16 +0200
Message-ID: <CAPDyKFqHBWtDioepsJuNHEa6ckwtuAOKBLx+LZEZctADTP--3w@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Sept 2023 at 13:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 25, 2023 at 01:26:27PM +0200, Ulf Hansson wrote:
> > We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
> > to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
> > up the code a bit.
> >
>
> No exactly. The stub is under !CONFIG_OF but we need it for !CONFIG_COMMON_CLK.
> The original build issue reported for which I add this was CONFIG_OF=y &&
> CONFIG_COMMON_CLK=n.
>
> It looks like it is still valid combo though I don't have a handy randconfig
> to present to you. I prefer to drop this for now if that is OK with you.

Sure, it's perfectly fine to drop it. It's just a thing I stumbled
over that isn't really needed in the $subject series!

Kind regards
Uffe
