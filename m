Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6891CDBBB
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEKNtD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730158AbgEKNtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 09:49:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1700C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 06:49:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so9736849wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjHVuVtBWSdENXXYiinZ4uI8mae/pV5Z0nfAWffhAkY=;
        b=k5UvlXD0wz5vs3V4Z1hLq6biCClQbT+SzjjXqeAWFhwqVN+GA6qeV+oLnHhDuhXDcw
         MVX0TgpYBV2DjO6YTj2/kloLSz+106Qm/fu9Fbt1wd7Q9aE3k+RpBPuqoe4B/zYzxdUq
         BWm+yMkxszNTBcpnFcQs0Byn+efwRCTcgItZvKIAw201wqDgUXYW7R4/7Cfdosha29v5
         hG7krpuspf6IGF5pvCDjIZnLghI9pcVt8KAQQzkY5BjrBvfl67q0XBW22UMkTBRK4S4F
         DLCrrH5eHw06BLRl64MM4YyqwuAW3hNxzvNkr+tVHeL/B126T/5EI79diNMMOpSg7Ksv
         7m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjHVuVtBWSdENXXYiinZ4uI8mae/pV5Z0nfAWffhAkY=;
        b=B2JPxumQIuslq/aFTELfFFnfsxn/e92PdF2J9ah4XtLRpxXkNd2aNOrK82aCHDV4Rm
         AUR78sACcW/JoM0QBxUzz6gyMbECLCCkmndgr6kY8IAvuseXcS0RoPhq5LOvFIxVBoog
         4DnD9VvpotgFQODLkbTssk+dJkoXSX/UJSC9AorjDbv2QHFoGpzwG/5AevoMQD+2xIb9
         NSj0OB9+VQw7qsAtAUkmJm8zerjv+ANAGc875sOw0D2r5LslVVjn7AF6VPNyKIYFPjzq
         s2UHXs+NvfZc47vwOPmNed5uzSXUXDXJpAFSCAfG5vFMTjNHNphfUpwTTCjDeFq1rCj5
         qGrA==
X-Gm-Message-State: AGi0PuZXoltfnQhEBadab15+uVBPn5gSK0u6R5/HJitZ9ksDYPX65kqH
        AQx0PDA26GJQM/QDq8XPGZQiNoBcOk2Cpw==
X-Google-Smtp-Source: APiQypLt90h3E4QOKCct7odHvidKqDIEKMSux9lbzqVHNQsX/QafgI6SnH5ciyxpl3mgK+o2GNzOyg==
X-Received: by 2002:a1c:df83:: with SMTP id w125mr22393555wmg.140.1589204939170;
        Mon, 11 May 2020 06:48:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a24sm26771229wmb.24.2020.05.11.06.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:48:58 -0700 (PDT)
Date:   Mon, 11 May 2020 14:48:54 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v7 07/15] Documentation: power: update Energy Model
 description
Message-ID: <20200511134854.GD29112@google.com>
References: <20200511111912.3001-1-lukasz.luba@arm.com>
 <20200511111912.3001-8-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511111912.3001-8-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 11 May 2020 at 12:19:04 (+0100), Lukasz Luba wrote:
> The Energy Model framework supports also other devices than CPUs. Update
> related information and add description for the new usage.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Quentin Perret <qperret@google.com>
