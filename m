Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A901EA1A4
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFAKPc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKPc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 06:15:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20450C03E97C
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 03:15:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n9so972264plk.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v6gFbJUir/7QQfuPHOnNakgBPBDjB8EHpKva8DT/ebs=;
        b=S6+gMGQvM1iS0TCQV05pZWZG3Q3adY0A//Rx+/ZnhKT5z/cEHNy4rOqCjloKqeUD6a
         +UgAzTR3wcMFHNHOTTsArdHOJktljTD6drhGdceJ/x9Jjmey/eB+9HMMgSay/exu+s1x
         pJ7rcAyh0NxuKTEUrOrwkZ7hWhpfvYUg6l2MOlai1K+sgXf3PEay0K10uGZXtjnup9uE
         LlmmATUPnJyYg3Vgdr5+HSeH8DEV4DgEAh+Q33MXp2vB7JuB2+6kIIs9PEmUMY9RSvM7
         7D7AJTasgybrEqCf9Dk+nT/4MgQ2x65tu7rYCRoKh8ohdlm7ROoKXEiNmv6jOqPVgEiO
         orpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6gFbJUir/7QQfuPHOnNakgBPBDjB8EHpKva8DT/ebs=;
        b=TSCOrmJkBou7VBj2E+M2o9nE7o7gCNhl2ru6n0KgLL/jz+VFjnymxUxGx7qCNCTRwx
         xA27O/t2N78wnFludXZx+BZn9BZlejkMPS1+MKa/X/Ircyyk5d0FYVTifzgB65YSU5Oz
         ulo/vmpLQfYzCEktJGUkJn6lgvACBljd0ct5n0966oKlJL3ESVyGTdijVFnihDcswBjS
         S6DHBIqryJspoO866fZUbYt0HlOAKF5Gbs34bjAYmgmhzYZD49zyLJSJR4x381A7NXfi
         NEBFNPGPVv9OEGDEXv8JdKG1crr+wwDQUEknGzObHMsgA6YNgP+Em5LniJcBh+/tiAyd
         4Mhg==
X-Gm-Message-State: AOAM532/8oKlHU5a1bR46iHBtGp/RaWQNYcfE6Kx4bYnWPObI5KR9hoZ
        uzDrquWWu5MyguvMBjDSoHN2eA==
X-Google-Smtp-Source: ABdhPJwV4H6FUA8zkCI+LMGgdo/y0cQyMSbmQ1uk0zIJ6IiQuKqrgjDFGTCP5wRMlCKOSgGYrHjSSg==
X-Received: by 2002:a17:902:7c81:: with SMTP id y1mr20302814pll.236.1591006531363;
        Mon, 01 Jun 2020 03:15:31 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id n2sm202750pfd.125.2020.06.01.03.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 03:15:30 -0700 (PDT)
Date:   Mon, 1 Jun 2020 15:45:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, nm@ti.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com, mka@chromium.org,
        smasetty@codeaurora.org, linux-arm-msm-owner@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] OPP: Check for bandwidth values before creating icc paths
Message-ID: <20200601101528.vcauy5fm5tmzgahs@vireshk-i7>
References: <20200527192418.20169-1-sibis@codeaurora.org>
 <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
 <0205034b0ece173a7152a43b016985a7@codeaurora.org>
 <20200601040742.3a4cmhrwgh2ueksy@vireshk-i7>
 <ee51e55bdf518832e4ecb2faf98c6b58@codeaurora.org>
 <20200601071349.gbuyfaasdu27a3bd@vireshk-i7>
 <4258c6b122fa352a6b5cccb07a9b1203@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4258c6b122fa352a6b5cccb07a9b1203@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-06-20, 15:30, Sibi Sankar wrote:
> Yeah dev_pm_opp_add/dev_pm_opp_set_clkname
> or pretty much any api doing a
> dev_pm_opp_get_opp_table without
> a opp_table node associated with
> it will run into this issue.

Not sure if what you wrote now is correct, the problem shouldn't
happen from within dev_pm_opp_set_clkname() but only when we try to do
bw thing.

Anyway, I have pushed the change already.

-- 
viresh
