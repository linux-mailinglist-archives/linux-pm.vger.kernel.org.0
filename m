Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07753EEE15
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhHQOHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhHQOHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 10:07:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D3C061764
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 07:07:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so10158897otk.9
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjrWqg5iL7My1Sr03I7/kUapdaKKEVG8PdV3gZ9eQ5c=;
        b=UAdw8iIf1KQ4XcA+YoXbiW2WnCf0aZvDhdzhGq6fdomVH2hQy6KaDEj3vfMHfALYv6
         TQpDbwuyoIKzh3hHatjWC2nJf9moQprUZ2tg4YEEqzp0MgLOa9hAhk/tzSDVL/eHIa+K
         AoqUgTV2lsAhSg8mt9FbUfK2nAgufws5OC++v03zH4Mzp3nPolTqZYC17k2JCsBaqqp0
         1pNRlPEZhNBxqDufiX2TiEAwa48cot/TPWXIcOiSizQH6GGJhGjZyr4KN+nvPN8Ci5ye
         z/mFkx04yvnmll+D0yTg0FHXOYXHEYLG3QM7swAErrb+wfe6X7k42bqTVmBCJoYERvZC
         RSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjrWqg5iL7My1Sr03I7/kUapdaKKEVG8PdV3gZ9eQ5c=;
        b=h8u/C9bdZkcZ5GNT1FR/X+ZdPxBdOtmethD6/hU/b9h9uQWMUwJCGtaFWYQA5L/Lx2
         gY8YJxEE9aE3Tdxch5c22taib5LzJo5UQbVovOkSWmvFv0W2PuCrHxSPwhXrZfvWsLxz
         u7r0pcczLAqLKrUw2lACywuWtPXN4sVA2Q9CcDZoZqAV0MOjoK2cJRCY5V+JWL6uPZQl
         Af9HDgXRsHJCldtAUE4/1ixxm604uPKhGro5CSNQGKKlBI8aAY3jtEicznm+qj+kSFqz
         ypOtl7dP+eu85S405AomWSDTPuDY6yGJ0c/ySNCiCUWEQ58KIOlhLsSQSmYgHH7WZTO5
         DQwg==
X-Gm-Message-State: AOAM533oHisJgo0JCHaFDJNFDv1N1ve6HojENG5dqv9q5ADaZWpkXJUT
        MqTM3po0XTEVR05kc/XOHgvEPw==
X-Google-Smtp-Source: ABdhPJxgbrZTySfGDM1CDSbpZKb3negyXgjIKPfl8i3ksWXyLl4lrCduMCUTEPkrjtnienG26pp+7A==
X-Received: by 2002:a05:6830:110a:: with SMTP id w10mr2663999otq.291.1629209223152;
        Tue, 17 Aug 2021 07:07:03 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16sm438399oop.3.2021.08.17.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 07:07:02 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:07:00 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        rui.zhang@intel.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        robh+dt@kernel.org, steev@kali.org, tdas@codeaurora.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [Patch v5 1/6] firmware: qcom_scm: Introduce SCM calls to access
 LMh
Message-ID: <YRvChF0j2NOsDuK3@builder.lan>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-2-thara.gopinath@linaro.org>
 <19659756-4716-4c5b-949a-58d362dcee22@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19659756-4716-4c5b-949a-58d362dcee22@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 17 Aug 08:17 CDT 2021, Daniel Lezcano wrote:

> On 09/08/2021 21:15, Thara Gopinath wrote:
> > Introduce SCM calls to access/configure limits management hardware(LMH).
> > 
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Hi Bjorn, Andy,
> 
> do you mind if I pick this patch along with patch 2/6 ?
> 

Please do!

Regards,
Bjorn
