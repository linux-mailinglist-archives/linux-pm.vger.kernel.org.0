Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C664F18C680
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 05:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgCTEa3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 00:30:29 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:41667 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCTEa3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 00:30:29 -0400
Received: by mail-pl1-f177.google.com with SMTP id t16so1973683plr.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 21:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FK0Qs/wfLDgNg2rYS3eqjZVtMnHsMPlZqWjF8TdcBYo=;
        b=VoT6snoGQ3wP3BQLrQfRUAilBySe7ZAr60T3PsA8dy1TlDvW6MazZXNga49xu1Vpb4
         NzZfimCvgPSZnwr7F8bCpxyVOikoJcCQvfUEhngwAx10xqHPrnSeEl5GSZkrinpd2RNJ
         rjtZtxQrdljLaCfjtJigd93CkgG2usYULjRs8GPATMF/HiC/uxcWfuym56k4DFSp3+HM
         0L8EgjULc8IC8vIleoP0/dbYGdDv3F8tA921LoLjyhvwg7oLbaUHE0jggB8v6oDL+Q2c
         eQb0pFNuwsHinMK+LAWuoyGIb3jY0T2B6Z+ADTfifLfuQFmGu4uJQI8QamvzM7vDACNT
         cVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FK0Qs/wfLDgNg2rYS3eqjZVtMnHsMPlZqWjF8TdcBYo=;
        b=NUi+XXd1PWl+2967/wPn0kfjq8qhbEsonlbsG5US13po79zLNLAJxJ/qo39zPLAz1H
         z98Hww7/gQGulDkFrFF7BdjKOdlU29SFkCDi8psGo6s041FBn5HDCLwz/sfBzVVrB9yM
         8oQWXzPwzNl9/Gi0UefIBju97Bxg7BuP33SxIOi89lVXGguGBgShcmldvecuO+Kxb2l0
         88ik4K2dnC6iZ8D7xciNEpyfsFhzLGJLvKVRhObNOHZyv5uz3r3Qs8VsYqX2AuSKH1Pd
         panOl0X/hjjdJEFXM8rM2VR/s1dyXZ7gR05s/HiHQOD7w1LA0WqOFZW+HViJXDm7Gchi
         daug==
X-Gm-Message-State: ANhLgQ1Hs8LZy0SyU3Y3hrOe27E16nWSmEcvCM2EuivV6FmvhIA9CrZ1
        nkLPn0nWZJ+VQBPwtLtbkJL7uw==
X-Google-Smtp-Source: ADFU+vvmD0faz/IDlUA+ugLFOG/vv1GJgyi24Xl5N3XX049X07fwpOu7GCTbxqvBdgenTWZz5ADTuA==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr6977222plo.62.1584678627808;
        Thu, 19 Mar 2020 21:30:27 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id h11sm3792633pfq.56.2020.03.19.21.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 21:30:27 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:00:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ilia Lin <ilia.lin@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: qcom: Add support for krait based socs
Message-ID: <20200320043025.xju43zbzmqda5wes@vireshk-i7>
References: <ilia.lin@kernel.org>
 <20200313175213.8654-1-ansuelsmth@gmail.com>
 <CA+5LGR3WJkwFGPWNM2XAqdhaNZ2yXreB8Ni36BKswx0G=i_5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+5LGR3WJkwFGPWNM2XAqdhaNZ2yXreB8Ni36BKswx0G=i_5fg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-03-20, 21:34, Ilia Lin wrote:
> Reviewed-by: Ilia Lin <ilia.lin@kernel.org>

Applied. Thanks.

-- 
viresh
