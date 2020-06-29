Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE94F20E1D6
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbgF2VAE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbgF2TM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DEC0086E6
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 02:37:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so15836826wrm.4
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kmk9PEgAXfYX2bQEnnaPEK9UG50WCVEeb9HUTIaZ6ks=;
        b=HIHVwEf3uKroAtkA2j00G2TvjJVsfI5vDmYQo9hgKekYiEtoI6uJu6QrzkRwqxv8/r
         hhbT2XlYMBMMTmZaTiyqQEdhfeeqSk5d393nidVqZa5EqXWLksVDv47GnfB5KRC3n0Ha
         1w68QHUmBBMvKngmvdR5yOM+rAPrgxUrVoqJexgAdhRr+7XgRmTWNHhw16n2gFqwB4LM
         rCpenAik59TMHvWskoZrozvBkNw0X60EA0TYO32KvhlyN/L8YqfhRFYvpRuQG3wWacqj
         kVFfQWTN5lghDM45tj8fKPm3AV5/Bfw/NuDkwrrZ2oSTro+dGeVFIQmifl1BuXvTy2UV
         i2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kmk9PEgAXfYX2bQEnnaPEK9UG50WCVEeb9HUTIaZ6ks=;
        b=Era/8HNlxGxxa/IKPbN4IjqzDPXDRF4h+EdqaJMjTq3pvD2vNlrG41bWOrHkuFfv/L
         xM2dq3ejViJHDTPf3qm6DdmKCvjktd6SEJP26t9yycxQqlrg6jYrC6Hp/99MZO4/WLVK
         ojrzhlxCjWVSNRfRQ1QDrer9lqlwklReLRK21KgQLq8qZ47VtQ77GMHykcOzDWUQQr55
         5S9ise3SCXMj+XepNNNejy4opJRbXMvPGaxL2zyyUZQxZDQCP9XQ2175HqZuXJzK5wf6
         TBJHWElnDizTNacMzCmCx2DWQHJYnBn1Hj1i3P8/aGdq93Fg/4q4TIMRMz91TA9m4Dkk
         HbSg==
X-Gm-Message-State: AOAM533G0u3tHgBEqheClRadf+I74UDbuqw9IgkOhUEQgy+If1T/Jf5v
        dCCkEb5YSwrTVrzwvv2K4tUrOyZK48x60w==
X-Google-Smtp-Source: ABdhPJx6Z/8IkgiDv1TC0Pn03hEfVmplxyRbpiorG1BP0etmk31pED46eotBFiDcjMQIaBTwUldYHg==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr15755850wrr.11.1593423474559;
        Mon, 29 Jun 2020 02:37:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id e23sm9731999wme.35.2020.06.29.02.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:37:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:37:50 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200629093750.GA1228312@google.com>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
 <fdc55a7550a6a6a95dab1c80ff94d461b8ba0664.1593418662.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc55a7550a6a6a95dab1c80ff94d461b8ba0664.1593418662.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 29 Jun 2020 at 13:54:58 (+0530), Viresh Kumar wrote:
> The locking around governors handling isn't adequate currently. The list
> of governors should never be traversed without locking in place. Also we
> must make sure the governor isn't removed while it is still referenced
> by code.
> 
> Reported-by: Quentin Perret <qperret@google.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
Quentin
