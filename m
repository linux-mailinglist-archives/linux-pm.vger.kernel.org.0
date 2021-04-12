Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1987635B9BB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 07:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhDLFL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 01:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhDLFL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 01:11:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D1C061574
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:11:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t22so8496601pgu.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tp3rw7ACn5Qca0HzmHOYsUTnPjwtDLgpX0UBUjpMWLA=;
        b=LVaiMAhAn+6SWxc6HV4IOaGCfv1+e7meyeLOwyvVP+JzgPDA3x66cadvth14orwtYX
         wDlPT21GEI35E7TMHYqZMx+V1j3x/Rd7d2LO1B1WuHgdGlel255onq6Cno2OQq2Qvcc7
         q40Z7MSm2Od/VDKdpyrEVHxTqwGWnFD13FUWSyiQ8/LJBU5FnVNO1pkgRh/Zu7AzzAIh
         R0P26E8MB37CifbnuUQjh/Lhc+glJXBlIBC3j0eQORBMHVG3a3ViU0iN+Z+Dni/0GrbC
         eipbNKzn/WGnJXwQkAfSYhWtWYm5hQXEboHbMPula469tvWtmrizLhLabA2p++QTBOk6
         daVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tp3rw7ACn5Qca0HzmHOYsUTnPjwtDLgpX0UBUjpMWLA=;
        b=AH73bWhjF/Ldvau8+HrhuHkwY7Y6EvoEF4ppqlY3gveLpEktuVanYgcy3BSUTaOKQa
         YW1CYCW/lx13g5Vq4XZ6cSEiAmNCW13PCEfl5Y7vvUAZLmlDKlrFOmBy5XhvGTaAMZyL
         oEyAzk98W5jObcABhpm/3YahMF+5oEqFo+o+aRxAREyAz8uhlW7PTBfNGF+70XIfrEtI
         gHK6z7q5QzrfYABJAmjmlgPm5R4uCBBQA2Vd7QnfzWWTMlcfw4hR9WtLDOq74uIXwwB5
         b/4n+RoCUodXpMqdyozW/GYN2Wl3NXtLxZWm7F+EuQDKDUIRycR2HAelPEUA1mcSETgJ
         1iaw==
X-Gm-Message-State: AOAM5306UDaPnz46JkNPzP8h3HXZdap9e/SIedTg5qp+HRGVuGLVfqGQ
        pnt7pbf6WFvlZj2eCzWO+dtgvQ==
X-Google-Smtp-Source: ABdhPJwL2wAhqV70IE3o3KvQ4BzPWB4w+DiXjeDExC+7GGNEmSK/gKTLJoEZ2RIIcij2AvHYuFlK/w==
X-Received: by 2002:a63:f443:: with SMTP id p3mr25328636pgk.378.1618204298689;
        Sun, 11 Apr 2021 22:11:38 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id m7sm9799571pjc.54.2021.04.11.22.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 22:11:37 -0700 (PDT)
Date:   Mon, 12 Apr 2021 10:41:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     bjorn.andersson@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        robh+dt@kernel.org, amit.kucheria@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 0/7] cpufreq-qcom-hw: Implement full OSM programming
Message-ID: <20210412051135.xtpokwrbclaptbot@vireshk-i7>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-21, 18:45, AngeloGioacchino Del Regno wrote:
>   **
>   ** NOTE: To "view the full picture", please look at the following
>   ** patch series:
>   ** https://patchwork.kernel.org/project/linux-arm-msm/list/?series=413355
>   **              This is a subset of that series.
>   **
> 
> Changes in v4:
> - Huge patch series has been split for better reviewability,
>   as suggested by Bjorn
> - Rebased code on top of 266991721c15 ("cpufreq: qcom-hw: enable boost
>   support")

Bjorn, what am I supposed to do with patchset ? Is there anyone who can give
this some reviews from qcom team ?

-- 
viresh
