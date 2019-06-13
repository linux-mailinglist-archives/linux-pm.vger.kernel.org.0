Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9247644785
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfFMRAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 13:00:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36079 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbfFMAEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 20:04:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so4720361pfl.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2019 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=enyuAfwIUm7QZb/zhVy1/4Va6a5/NPi/JrG9djy3bF8=;
        b=GQXJaktvgKtFOEDW1sUlsUsVwTuVAnIA8hh4WjxCiXsXvlvtfRzGg7etclRAdgKv4U
         4ShkffdYG971cLxlYNt6mPgcxcVKbfFPcLkX7gZMRMy0uHwgTA+CLDAnKeuUPidLGO3I
         bqwz3QvEooRJpl5P8hL/GSorok8hu1ktGl9+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=enyuAfwIUm7QZb/zhVy1/4Va6a5/NPi/JrG9djy3bF8=;
        b=cM6nOxmQEGWylFmhk1lbOcx8NpA+uR8TvQQWwxFwtEpP3kQVtnVN6h4a1P+G1o/KX8
         HMFASg4au+XBrjMjRoiIdKYwXvaC2NNJMtx5+u5Q3dZrWSW8sviUfBIcs0qgNaMaO+EH
         R/7Nb2ew28OO9AUauccUfF7SP5ZSqhWeJOjpYU559Z2s2jwF6YaZurK2A0YW87RclY+b
         l23Gj3/nqbDe0DsrUCgqywT0pXDdR88xzkukqM86x4I+pul8A7Bjjm5W77zl6pdFaiW3
         MDK4WYi/hEJHfYLINieQlHU+ImHBeWDQH3xGp6HfOopNrIlavHivnFitwsFSnczc8y8U
         h+tg==
X-Gm-Message-State: APjAAAW/yJjiUpCXtj9feHWGNHqNlc8y8Dk0NrKEgSJBhpmIpilV8VHZ
        sHDG0EY/KKfNDYe4yflK+oTx4A==
X-Google-Smtp-Source: APXvYqwO5UFiyckgdUgkZVSFQmP4vYWEFYVqaJ7SB58Em//0AXY36VhkhuJlG3u3XDCMdNZATgT/Wg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr1876181pjr.116.1560384284934;
        Wed, 12 Jun 2019 17:04:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x66sm642436pfx.139.2019.06.12.17.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 17:04:43 -0700 (PDT)
Date:   Wed, 12 Jun 2019 17:04:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/5] PM / QoS: Add support for MIN/MAX frequency
 constraints
Message-ID: <20190613000441.GM137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 04:21:34PM +0530, Viresh Kumar wrote:
> This patch introduces the min-frequency and max-frequency device
> constraints, which will be used by the cpufreq core to begin with.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Again, I'm mostly ignorant about QoS, in the context of the
existing code (particularly looking at DEV_PM_QOS_RESUME_LATENCY)
this looks reasonable to me. FWIW:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
