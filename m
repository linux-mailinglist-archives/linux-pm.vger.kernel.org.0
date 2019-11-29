Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8810D086
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 03:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfK2C1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 21:27:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38898 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfK2C1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 21:27:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so13238983pgl.5
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t99PgAEcDTrMbHbkn0VufWJ/LmM4ic7BKjRhA7eNd2I=;
        b=RcqcwBt6eY/UrWvwfYaBa+6RtBq0XGSmc+UQiEkU9UOJeNqj/lNbJrtRDcZbJLDsI/
         Rg8pj4oIy8uUjKscBC0oLZl1w5VJUVNuHOjQ7oWoDaGoFOyKAuoYf6Uvx2KXQOK3gE2O
         CbMGfNZeRXyR2ruuMfojy3+WWl+VSFbZ1qu33I93gsEg3dXSagHGePNZkGuUCfR9xTHw
         D6Rp4fOoV1P/yjtfg5U1rMFANI7ZQLfenHovGZGYyWKF0TDrR32mCR7YY8LqPaEG3nLE
         r03vzblIZ49fZ2sYEvStfOGKY4UlR7yAA6zgTsHVB2zRqtBmlhb6Gy52/cYFn+qqsgB3
         O1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t99PgAEcDTrMbHbkn0VufWJ/LmM4ic7BKjRhA7eNd2I=;
        b=TK/r2T0BJGdZCpXqka4akmSjKMsnVrg+yBVyVy1i/GPNfcILl+m1xWn4n6leV1v8P3
         8KcgsGYGYO5ASa5QlN3+j0s9ukrsW5h4AJAy9TI0fxLGVWT2zj3E6bfTOX1SeBeR52p2
         V2bQlr2If+XmUEgkO1sPpm2tnVM2XCI4F9+oqA5XF3aWKm1czDxeO3W2lvIzaVTj7b/i
         aF2QLglU/zxXGtBg61dqLJaaOhjqbpXLwc5wjfUIEo/csOIQL72fdtO6298PseOpxOlg
         i7ZKHtHycSZFa7jhFSjfSWXRB7V0xNp6DaXQze19V/993D/XbeGs55P9SoEO1c/+S8Yx
         HXag==
X-Gm-Message-State: APjAAAVsmf3s6fmF44wcnhtMgI61VTl4IcewTkkWf4PhFpps98Uv/wch
        8tclEIt9wqHkucwqOyDNrQlO5Q==
X-Google-Smtp-Source: APXvYqwQu4kSaLlq3LbFK2l2M8AthW8cvU/ZXw8ZZlj9vXim1BolXdXPBnjWsVUOT1XznPiXIWSAOw==
X-Received: by 2002:a63:9247:: with SMTP id s7mr14692233pgn.334.1574994428728;
        Thu, 28 Nov 2019 18:27:08 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id y12sm12458359pjy.0.2019.11.28.18.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 18:27:08 -0800 (PST)
Date:   Fri, 29 Nov 2019 07:57:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: Free static OPPs on errors while adding them
Message-ID: <20191129022706.rargieilar3dq3pg@vireshk-i7>
References: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-11-19, 16:32, Viresh Kumar wrote:
> The static OPPs aren't getting freed properly, if errors occur while
> adding them. Fix that by calling _put_opp_list_kref() and putting their
> reference on failures.
> 
> Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

@Stephen: Any inputs here on this series ?

-- 
viresh
