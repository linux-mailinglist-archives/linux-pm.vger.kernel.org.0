Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B945E27729E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIXNjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 09:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgIXNja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 09:39:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE3C0613D3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:39:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so3884234wrr.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pfqIdita6c/68e2NAo4Uu90/hWr0DYIKt/L27IUDUD8=;
        b=tgoBMDvkwf7H0OZXkk2mkhIauR+Wst5CQkEvZQ5j2UqhfovQL2vLK536s017HHzsAi
         vjjHX+9inNnCHrDw2BwHz1g54ZgeeaEnWveVt8YoklWi0bVJI3y3A2sSCc/MGRBZiHBe
         iRyK/2wBM3y29rdMkz0JrZ3wunnqTsbngTVWFil8gAw3h6eA2ouSVy1Di1EWYkk704RE
         +RolO85TuYSz9lrFG9n+Ko0SfMDNxRh98HPb2rIm3v9krNGMrfYscA2xwfaSOgcyQtpI
         qr/k813cTVYaQsRPiZCCk73dim1bZuYE3iHlIZGXxd/sJQb0B/4xGDA4YwbVThMe5lUE
         kmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfqIdita6c/68e2NAo4Uu90/hWr0DYIKt/L27IUDUD8=;
        b=tp9CFU6LfUWXE0E7FRMREyjUh7PAnMY1izBMYwt/W8L+7vH/ZHA/LpJn1cMP15CoZO
         UPulVPXiZIfVBoWPR4Nmqnth8GxJPaednN0CUi8pFexE/XkddThfWkTmkHIQkijnSMCT
         131em2qiSjxdpxGBOnYrPHViOd13oW8+VG8B0AiG+AwWiqmgMGKQXDjgy88hjGzmrJGE
         ogIwQn3DRAAsY5wtC9YJhTgUGzamtwysWznqAd0oMHGaAH+9p21CS0F21Mp+KbcHn/yz
         6bOC2Knkjymqai+fYPl//7TzFoxQwvTOLmgkORxijIN+YI14kdgyZJXSLN+87W3AXMOH
         /D/w==
X-Gm-Message-State: AOAM531NuOBWfHHT2e/EhMSZ3jIuNH9/TWTHG0uTb3qZDMjYUhBDWXcj
        1MH8G6OBDE6VPdzJKkVvi/94Ew==
X-Google-Smtp-Source: ABdhPJywsWYBXZf2D+jFaHHQXUz0+dY7LajwjQZiNSTlT1AIlNxYxWQZc6tfm5+QO22WOg4o0KQPlw==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr5584996wrq.302.1600954769183;
        Thu, 24 Sep 2020 06:39:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id 2sm3432548wmf.25.2020.09.24.06.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:39:28 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:39:25 +0100
From:   Quentin Perret <qperret@google.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: rebuild sched domains on invariance status
 changes
Message-ID: <20200924133925.GC3920949@google.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924123937.20938-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924123937.20938-4-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 24 Sep 2020 at 13:39:37 (+0100), Ionela Voinescu wrote:
> For arm64 this affects the task scheduler behavior which builds its
> scheduling domain hierarchy well before the late counter-based FI init.
> During that process it will disable EAS due to its dependency on FI.

Does it mean we get a warn on every boot, even though this is a
perfectly normal scenario?

Thanks,
Quentin
