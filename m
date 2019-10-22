Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3ADFFB1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbfJVIj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 04:39:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40829 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbfJVIj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 04:39:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so4165468pgt.7
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eApqYsG4e2cicMJq62zYg3NteuGKFbsXj+rZHKlYrI4=;
        b=cDDUvT7tE6kS1y83Xq++77H6H+Yisw1zBg5XQKZM01Ku2NMUOCvt+fjK9vnwStNlMd
         G1XP7moU287HDuI+90wzDg4KmHiMAREfcyjZgBDWnWhXGjZIXyxGj9Hlq2/rlvv/T7Vr
         QcwefftZNu9druK8hY710/5qE2kykFpQj1gXoPUCbNKf+yt14RoqzUnfUzDVZLmV9oSF
         0qYRgRJk3HtZycxlHl/UQXcjaZ7nNc1QQ1C708JwIPoSi+cVt7swoXR6fClCxm4HiBS4
         jj3nUyN+pUpT58Uk6c+SbtgRwXF0w2mr7msDr6HQaqaNxVzWxfd+l6C7PoK1zEe3odxK
         TO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eApqYsG4e2cicMJq62zYg3NteuGKFbsXj+rZHKlYrI4=;
        b=PEbP/8xJAo42a1CbqcneKApZ+jV01rk8Y8KnL3imil0ldSuDhxO6m8MV/WFN/TE/S7
         p/nGAAMpVjdJanjVg5/INHxWk2feziGZug59Ncc8888kJsyxG0O6SLWuCTkzLD0L6stz
         hvLAiNLIypJSByMBaC8GHv8YKxfZq7Iio/3mjvd9c6rRQK9X4UBk6MlmAeZGUaHgV3cC
         OipTDLf+5qrZmBqFXk+y12wfQKm/JM7Kcd8zTxR99lCoLGLy7liUN+WhlAf4yXOGBFtL
         /Oi001OQn2+ZSZAqyiz/RZKw5l59ENa30jcs2h+/biXt+o+srGpnMaa97ZO/mpTZcagv
         yvmQ==
X-Gm-Message-State: APjAAAWqynGe1iqqddJvDlq32UVtCaVIYJent6SGTz4f0Dq4CSsMRyli
        mQ51INMO1FU58lJICoa/EgVxuw==
X-Google-Smtp-Source: APXvYqzoU91PMefRaVNwx7NkTM3WdM9pc2FdfwqZ56vV/RMHqHndA6hwGJsvhbRBkt0v+CwbGGBDLg==
X-Received: by 2002:a17:90a:c406:: with SMTP id i6mr3159050pjt.98.1571733566156;
        Tue, 22 Oct 2019 01:39:26 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id m19sm15343255pjl.28.2019.10.22.01.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 01:39:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 14:09:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rafael.j.wysocki@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default
 speed grade value
Message-ID: <20191022083923.pjqfokyoegispumw@vireshk-i7>
References: <1571733199-17406-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571733199-17406-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-19, 16:33, Anson Huang wrote:
> i.MX8MN has different speed grade definition compared to
> i.MX8MQ/i.MX8MM, when fuses are NOT written, the default
> speed_grade should be set to minimum available OPP defined
> in DT which is 1.2GHz, the corresponding speed_grade value
> should be 0xb.
> 
> Fixes: 5b8010ba70d5 ("cpufreq: imx-cpufreq-dt: Add i.MX8MN support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Improve the coding style by removing the tab;
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied. Thanks.

-- 
viresh
