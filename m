Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9711FDD4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 06:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfLPFOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 00:14:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36363 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfLPFOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 00:14:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so2976976pgc.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2019 21:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4tAJsQUYEH96QRekobXV8hZQE4YeKw/mZfBdVHuGi8Y=;
        b=vU2NvP/+ImU/+phWf6dm2B4B+y40+UqBMir5Sh0FtMyYKIrsC+cfe71kjekqouYf+Y
         EWFRtOadzJU4nj1tuIs84faGk80kJVpc67RvKb85hIRKc3RjsKzQIwMu/inAvJ3GIDKv
         Vlaavj9NwPX3PVEb9oO6axB4WGpzkYljw6SHFGTN5lOZ+cJWHnPNGzb+E0AQ2A9dfsFL
         97/vs13xxmYL0jzX2g8P4D4zSHvjH/M+FbPUQyGXEYix0mLUMPI2wVZ05qT92BI/xDir
         E5V0NHekfgqZ3Vo1Ak2FLhMo8moE0OkiZB08l5RHuPE3AH9GwvBbBWrlNcQovONqP6Q8
         WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4tAJsQUYEH96QRekobXV8hZQE4YeKw/mZfBdVHuGi8Y=;
        b=YIAdprNJIJo76VcQLJp0wRdfRYS0uent2VVSDeaaG9TyFZrKTv6F+b8KBF6tX8ARvO
         ZlPVkiHxOOIKaIlvSkAueMNK1VhRcVxrkuP5lhearHjrX3u+5SxABTOzTuiSmqiKJNcp
         HKz2yjbwdZQPeA0YOnrVc3vMrofusD8048hg5yo4CEyX6beOktWN7N04Kub6p3pRvOvC
         vp2eX4t9M9SR34g5gH3Cb/4ipw7IigNyZc8dwXOGW2DK+nb0JrnWNnTnjMzqlunSks04
         p/D8ONGOK6c48+3WsZB8tQhLz3zL1pkESVV29KvYZ6O8MflpJ35ymjVW+Vs1/SdU5dsP
         rUvw==
X-Gm-Message-State: APjAAAWbgVYTBiPgNQyt+2+tZ8raBmmWXU4G/1TfJTxU1MI8Y9ceAAvT
        ytwFdpDwiEIpcZi3eWCilpJsog==
X-Google-Smtp-Source: APXvYqzC5De4BPX/MiHF9SP05W5ga/3NbLK9xx+Hd08yHPq3qnxcx6z19dLTZJYraPd/Ky7SSiEDCA==
X-Received: by 2002:a62:3784:: with SMTP id e126mr14101294pfa.228.1576473270160;
        Sun, 15 Dec 2019 21:14:30 -0800 (PST)
Received: from localhost ([122.171.234.168])
        by smtp.gmail.com with ESMTPSA id m3sm19486667pgp.32.2019.12.15.21.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 21:14:28 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:44:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: Free static OPPs on errors while adding them
Message-ID: <20191216051426.pizsckvvgx7qxmpc@vireshk-i7>
References: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
 <20191129022706.rargieilar3dq3pg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129022706.rargieilar3dq3pg@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-11-19, 07:57, Viresh Kumar wrote:
> On 18-11-19, 16:32, Viresh Kumar wrote:
> > The static OPPs aren't getting freed properly, if errors occur while
> > adding them. Fix that by calling _put_opp_list_kref() and putting their
> > reference on failures.
> > 
> > Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Stephen: Any inputs here on this series ?

Last ping before I queue them up :)

-- 
viresh
