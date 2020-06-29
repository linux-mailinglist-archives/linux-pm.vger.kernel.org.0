Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435B720E04E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgF2Uo4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbgF2TN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C0C014A93
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:04:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so15476883wrj.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJu5T05EGIesmOT82QcK4tvM42NAPTrHSyac4x7F7pM=;
        b=OQ0O/ji3YWaPUA5LVTl2z+7oIv8oHPXXajbTo7gN+ypY32l7m2S8IHDthtPNy8PmUI
         3/RB2boMvLnFXERxlvImDeRSrAmCnr84vqbj+hoK2UVr5jSFPlXCeqfbMYmnw1DtZoCz
         wfz1yX5KxVKQ6+reINQnT84GX4kzt3f1463mWC00vcmx89o7eIJH2WBtTTb6QhFyW9zQ
         hvK7Bmre+NIIGJTAvrlFsQZAcOAzcIg6D0DdL6rfZhqpV/wAzAA6fh29DpdZ9ZNAxsLf
         s3cb2tlXJHAcIrAd+N8AfFxDQm6sFD8UFJa97ojLl9pmTExTdys+BJ+NBS1K6M7wPhlo
         e2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJu5T05EGIesmOT82QcK4tvM42NAPTrHSyac4x7F7pM=;
        b=QSTFj9S1t29D8Z+5dxZ26TrPbzUANDBfV3VKpb97mrVRplIsL6DUFxjNJh+UPWrlvC
         RusMut7LlYeRHvVLMUONSHXPGYLSQR3yYuunJILuC8yCry8+RdM3/DtXDkP8AHGRmWio
         qgHHL3e5LcgZ8U9LMFcXjtzGKnYACT1HMAa6OOoCI9SZfAg49/sn1Dg1XUSOViBmDeHF
         eUdLZCHp+o/gD73UoqoSvK8Ainr+gSCuxWQoRcmpoSDvyIYDH3XWWzL4S5CxWiCKENn/
         AsFCZXR8kv/nnL3VW9U/kfpkarADqSKiR03eYamHWB7Ru9qGOL409/fkyYhvx+jM1ODV
         Lc4A==
X-Gm-Message-State: AOAM533wtULgEutNPMrVhighQdrpEXBo2a8oku5YwaqlL9lxoMskoiVl
        aQFPw05MsiRgOdexufxKnDyf0w==
X-Google-Smtp-Source: ABdhPJxjhHOLK/OLS+QpmEsbDw2KsR8ghE7pxziLY6KM8n7B0r5tY5LBX2zBH+b5fLJzKBlhjiImZg==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr16758755wru.115.1593417842938;
        Mon, 29 Jun 2020 01:04:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a2sm31496362wrn.68.2020.06.29.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:04:02 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:03:58 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200629080358.GA1217385@google.com>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <7eb38608b2b32c0c72dfb160c51206ec42e74e35.1593143118.git.viresh.kumar@linaro.org>
 <20200626155750.GA540785@google.com>
 <20200629020843.erntkwfprgi5ugqu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629020843.erntkwfprgi5ugqu@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 29 Jun 2020 at 07:38:43 (+0530), Viresh Kumar wrote:
> On 26-06-20, 16:57, Quentin Perret wrote:
> > Do we need both cpufreq_param_governor and default_governor?
> > Could we move everything to only one of them? Something a little bit
> > like that maybe?
> 
> No because we want to fallback to the default governor when the
> governor shown by the cpufreq_param_governor is valid but missing.

But that would still work with my suggestion no? You still fallback to
calling cpufreq_default_governor() in cpufreq_init_policy() if
get_governor(default_governor) doesn't succeed, so we should be covered.

Thanks,
Quentin
