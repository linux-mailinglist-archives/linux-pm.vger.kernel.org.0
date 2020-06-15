Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922331F9E90
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgFORcv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbgFORcv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 13:32:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7D2C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 10:32:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so8102826pfv.11
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXiTVmySLinwx/ohTb+qSbZFWKUCXVmO5le+pblRvB4=;
        b=G0mA6JzChysz4vfhRHU6jq7QE/eHCQELey0LnpzfKSltZnUX4xJrQcsFvDqNuuzn/B
         FQxQmO1cTFK2rwGfPExYUmB1UGc+D0FhPK1IWgrpsi9Tnelh53bMnIAGxe548hlLCDgz
         K8Qxo955RfvfEP5VJzZbZ6z34BV7rZNu9ZAzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXiTVmySLinwx/ohTb+qSbZFWKUCXVmO5le+pblRvB4=;
        b=Adpye+HvpLPafs6O/Qjk//HeXFlwysBYr4dYcJaD8sjjxjtjwLMWxAzj4l1gBOqGi0
         iK12oin3kezsGRLByYfyt8SjJOrSqMk9jhmFuw5Kc5wqKGfCtDd2IU6J43q5jj+zNIZx
         Uy3U/QGQCIyf76y91g0FHeZzr7cbRp/AuRY0gnteakBpbhOFTzHvgMKQB+ui8/qGIu7S
         mysl48yjoHgq5mOcmL7dgi2uTEF1Vl5oxWJLtok7DvD6LZPqM7NBngc8YHQsaN+CAuhI
         gaX+0akf05LG8Qi3zkdnB83SqCPMFwJtFfGRnholBNXFYE7J1xuytdysAdTRC29pgNmv
         LN0w==
X-Gm-Message-State: AOAM531JiUZY8AabfjI726qKBGzzBmjjqxR5I6XgnRf8/VgyeZksANeq
        +u210YkrS6hWtafXQ9GEuTlY0Q==
X-Google-Smtp-Source: ABdhPJwx4PYvnCYX2JxTXMHgP55Wrhu8eXLVeZVNpAxBLT0KLVHVOQYT0WO997vdvPGw+oFzo0eXRg==
X-Received: by 2002:a62:194d:: with SMTP id 74mr25149159pfz.21.1592242370263;
        Mon, 15 Jun 2020 10:32:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f3sm115586pjw.57.2020.06.15.10.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 10:32:49 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:32:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 5/5] cpufreq: qcom: Disable fast switch when scaling
 DDR/L3
Message-ID: <20200615173248.GV4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-6-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605213332.609-6-sibis@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 03:03:32AM +0530, Sibi Sankar wrote:
> Disable fast switch when the opp-tables required for scaling DDR/L3
> are populated.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

not sure a separate patch is needed for this, but anyway:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
