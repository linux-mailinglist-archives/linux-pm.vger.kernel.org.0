Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AAC2B5D57
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgKQKzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 05:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgKQKzD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 05:55:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C69EC0617A7
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 02:55:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u2so10026088pls.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ9rf9Tu27SxIk+03VeBF6ah9AiWAmkZ8caQiD4rxC0=;
        b=zh7REe1V6g6SzZqzuG0FgOF0qRE4Ee6PBvoJ9nkMBaOpMcAU+HPz7/NZTZkLnm3Rc5
         jKkJq/0eUB7kt3U9gIt+7mV9oR9OmHU9Ya+8Qleu09ROuyvS6oBxA0Y8YixTXlLlpVqO
         UEZPJPDiqQRorWZnnSllozNq0ANNQr2vrGni9ApCnT3UFRX4LUgbu/iV06cATNCB0G58
         dpuAl/VYn5U5nxiQijpqotH4KguB+g5Gpp5O1XydkJHkCAEU4weFWZ/5R5BUkH7xGoEY
         R5A8T+ltLnBVngWkwyU2wkE/O8Pn0hzLYFeAGFlPw1WY3ORGqmFlLlnrL1lm5umP/hC6
         tT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ9rf9Tu27SxIk+03VeBF6ah9AiWAmkZ8caQiD4rxC0=;
        b=LY4rZP7cFzj8UX3UtHX4T3WpwNstmobFbb03v12sfdvsG60u1NH5B8J9yrGAWYGKdh
         kHc+j2X1g4obgHK0jsOzmnYzTGT+m+tJpj449L79DXDkhCB6ebrzd7/coHe8CPYWx8kT
         kKbK4UxbzS79KYl8eG/nyHJX0rem2JRUa32UYzS+cdg48qV1uIF7ssWIFiifOo2X1ijB
         1bRICBxmkxI5+WUClcBNEQMytFLFCIxmI7LkJnQwgOJv25WZapanPmjLMI0kkVZXZJmZ
         BmDUoeESl+W/kjqViuQBFJzBijzmJ2c9cvOLYQfSkNF8nP1Ta0zK3h+rR2jT/2jY45sK
         Ak1A==
X-Gm-Message-State: AOAM532VA7gW9TfbOj7LEJHAh043IjaJeU+dNaierqb+i1+psY5kFeqZ
        kIUe00lCV33sbqYtrBG7ANSp2Q==
X-Google-Smtp-Source: ABdhPJxkTetKMQ8NIopvVvYdFNalwIpPjrKHgDjIhDVA+vQxFA244sZo+bs8USWr69gtaoq2bSufHg==
X-Received: by 2002:a17:90a:7f93:: with SMTP id m19mr3707452pjl.61.1605610502752;
        Tue, 17 Nov 2020 02:55:02 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id e184sm20923760pfe.146.2020.11.17.02.55.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 02:55:02 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:25:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201117105500.m3wwdlrsme4iiu7e@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
 <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
 <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
 <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
 <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com>
 <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
 <117c6d30-0013-7222-dedb-57e65ba84d15@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117c6d30-0013-7222-dedb-57e65ba84d15@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-11-20, 10:47, Lukasz Luba wrote:
> Fair enough. What if we come back with experiments results in future?
> Currently we are trying to conduct experiments with Nicola on modified Juno
> firmware and kernel)

Sure. If we think it improves things, why not. I just wanted to make
sure we understand why would we go do this change now.

-- 
viresh
