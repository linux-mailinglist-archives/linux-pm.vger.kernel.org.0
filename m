Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC54241EFC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgHKRMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgHKRMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 13:12:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F208C061787
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 10:12:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so7560537pfd.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EsxvtyjzAtXg5sUDRqzZVjThz8mBMWSIwRhZo+xufo4=;
        b=Qiivl9DPtHJleh/lzS440/NKVhFXk3Yy1tWl92a2XnuJBOWGpKkpkGQl+QJmRmUPp0
         sDzsmRLVz2R37jURWM0y4P3pazpzreDvZkb2OLaFUJlIpyR1cLyi7GqnTtnXBM0bio0o
         bcboHwDwhb+GNzKUDQCnK2Y9fT3vbSkutIvV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsxvtyjzAtXg5sUDRqzZVjThz8mBMWSIwRhZo+xufo4=;
        b=hSBkLfUqnvfGgnYWY802BkXGKLpmyTpVI/BmqFaKCFe3k31dY0/VkPl3LX3A58/fE9
         PRlH+j9WOi0EdBksHsQMegv00hVqWIskNbCzcMFO39+k8dzxFXymUv0C6c9Au7XE1t9i
         A36jDeTQ9GZDNtZTcsYTf/52lSZMrbgBdn6G6qtEgjjerXmrMES5VHsGIPrzDlvrYzrx
         CAy0nC2XgYHw27/agLXJaa+vlMjv7T99YQJg0eEHE/0rB0MHGzlAksPgxB3FUZpIwRmB
         1Z0QgwkTIpBjrx8L4JRrbqnWxPN1ehCYOo47f5Hf1mqZTbRW1pzXhPOWMBYb3cKPRfoL
         xpjg==
X-Gm-Message-State: AOAM530DAfYTvm557e2gkWx4Ib8Ie26L3L3Ol4ImW5hxXzoS7mwg3b+V
        2JkwZYELxjuznwu9wHFDRZA25L8LRHI=
X-Google-Smtp-Source: ABdhPJwCvHLKBQO7DAmqBUXQnYRCHWLQK/g0UXohIgdSsjGgJ0tacFUZGTDws11zC3WzqMh1Mwhn1Q==
X-Received: by 2002:a63:ea41:: with SMTP id l1mr1644202pgk.419.1597165970845;
        Tue, 11 Aug 2020 10:12:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id mp1sm3589375pjb.27.2020.08.11.10.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 10:12:50 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:12:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
Message-ID: <20200811171249.GL3191083@google.com>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 10, 2020 at 12:36:19PM +0530, Rajendra Nayak wrote:
> dev_pm_opp_set_rate() can now be called with freq = 0 inorder
> to either drop performance or bandwidth votes or to disable
> regulators on platforms which support them.
> In such cases, a subsequent call to dev_pm_opp_set_rate() with
> the same frequency ends up returning early because 'old_freq == freq'
> Instead make it fall through and put back the dropped performance
> and bandwidth votes and/or enable back the regulators.
> 
> Fixes: cd7ea582 ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes")
> Reported-by: Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>

Originally-reported-by: Matthias Kaehlcke <mka@chromium.org>
  https://patchwork.kernel.org/patch/11675369/#23514895 :P
