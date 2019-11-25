Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F6108CFF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 12:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKYL34 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 06:29:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36634 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKYL34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 06:29:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id cq11so6485422pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 03:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/cIxQGEQ/DUM0dfywh56ifyHjXEee9e2tzaaXp0e7V4=;
        b=cesAE+AqqbiY1WdomcikgmzmJE6HDoFsAkVWyJ121cFPSHxaJQOF5fldtm858Ge83m
         /oa+tgWDxxhCP//lEarAT+0S7jiwLiKC89h4C39s7vmUYpoBIFPeBsZrwmPS6gqQ1s8o
         Yz2cwVO+3zl/5OXggHgJK3bGbwnhUFpRkVpgbBeTXNNIiNiZOwbcvTptdlECNBbEvVq+
         UlM576tFF7gcNqM2QE6UieukoFl6Cd/esUjx9tzmdm6B9UhtRMAebgS4BeFBB4jnPNha
         48u9X2/KZAt86GxgB90PcqNJ/aZH21yENINHhQt8wx8oo7GK0q7v0joSIL/asjZCinNJ
         IlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cIxQGEQ/DUM0dfywh56ifyHjXEee9e2tzaaXp0e7V4=;
        b=KItrFsAO8KhLfuVA0JIrjfJ0hN1Gs292Opkytv8rs/3tXg+M8UZQacXp0EdaHLQF2B
         E+hGTDlpuZzWWMLvKjPXzqnKcdO7v3C87W/dMUqZR7n1+OwAaeDBvZQrZ7PuKkCMbrnT
         odAFXNqw2El+fZcIQ1IJYpCVqAPsxpH7/CC+zxYs48k+BwTC3yKDn20uwrPyvwxuG7vH
         h6lP7N/s/zAXD5nVIjmFRWyhpU5N56f9w8L/GKtwR2biA3wYOK8LthlbywH+/2H44l0N
         5Lhqp5xvtis1E3eReowUWmOis4d5zYmibAt3mdGY0wMeMZKPxhf8dTgaKDvUGFOX18CD
         D4NA==
X-Gm-Message-State: APjAAAUDCjz3cyVIoo1HGMh+sF6kOl3T5CyLg52zIpK9Oliddca3PdZx
        mUJGAQJelTy16a8n7kJvCyPlKQ==
X-Google-Smtp-Source: APXvYqxzUrU7FUsukHWHjVPwDDc93d8pAnp5DEfWMt/ja5jtZpKYBfCcgCc/zgRPHo21TDN9C8K4Tg==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr38600012pjt.95.1574681395345;
        Mon, 25 Nov 2019 03:29:55 -0800 (PST)
Received: from localhost ([122.172.119.235])
        by smtp.gmail.com with ESMTPSA id s18sm8369634pfm.27.2019.11.25.03.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 03:29:54 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:59:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20191125112952.uwrmeukppkqu4hvm@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-11-19, 16:58, Viresh Kumar wrote:
> Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 25 Nov 2019 13:57:58 +0530
> Subject: [PATCH] opp: Allow lazy-linking of required-opps

Forgot to mention that this is based of pm/linux-next + following series

https://lore.kernel.org/lkml/befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org/

-- 
viresh
