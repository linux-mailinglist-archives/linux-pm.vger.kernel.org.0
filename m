Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AA3599CE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhDIJtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhDIJts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 05:49:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEA6C061761
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 02:49:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id b17so3491558pgh.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WXMG0YEw15ER/T/PglLrmWeJ1o5ISuWKQsalZWJzPfE=;
        b=aEPIT4CQi0j9iRxIowyb/QqZ12cy8VGTsZTUosyyexV3QGo4c1wh4cKxNwzUdQyVlR
         IVnlSD3funYG0a3TFf0NZs42vIkwSUCeMjNJJkDO7k7J9hQ4zktxJ5/Ut6iz5w9Iy+Vu
         f52gOPXzcgf0tR0jn9SQAn1Ed8lFiTQve+myyJJepkTMTHAttpI1LX5wNpVXZuXJKD3d
         zGLpgpyYWyuNt6DezEsG5IHV3xbtKEZoTf7DyBYgE7XEzb3qoZBHcHc6pmgzTP/100zH
         VyZV65SAZfv4mhUhlnneKFPlQ19xc392VOd4Z/PFUd7v+oHlnOYaHV2leRZcu1mTb3VG
         zfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WXMG0YEw15ER/T/PglLrmWeJ1o5ISuWKQsalZWJzPfE=;
        b=QGJPWyDvuDwJJRwIOXduFuf/4sQUzul9/ombz/VvJikFbpQbDg3EvbrUISlTsu6x1Q
         o5q8WXeE7MEs/ozdI5QXC0esXAvEK21FPEiBzZpjir7nVLcnPXDMQOWEYONCcjh2NdHB
         GGkP0VaPY65LZ1peN+IYQkLUgQXFwBmj4Baet6CVcsQKbUW3rWKVehtWf5ZZdh4FAeMG
         TjDpzPDH3lWGwDGjzy+gl62G6m0xuG9vwL0nGoaJnFoVqmI/gl6zk55Dh4aJR0z5dalX
         C5/oYDUSzsKbWOy0gnrZDUpXgu84TigCbwGjrPPF+VHHwVPiGyghKGKKSJk5mDCfhXfG
         alpQ==
X-Gm-Message-State: AOAM531mwQW/PQihKxO8/6dTjUsUw7gdFK+nQuCZ1sjwJB9fXFCeTuyZ
        Zb22t9kT9kxt+xQyuP03I39T4g==
X-Google-Smtp-Source: ABdhPJx7UxkIAyJw7SOklIEdXRZTT6Fx/+KEWurlcoj41yv0ta9qBT5NtTmVTou6LA89mn2T8vDYvA==
X-Received: by 2002:a63:4547:: with SMTP id u7mr12445971pgk.351.1617961775171;
        Fri, 09 Apr 2021 02:49:35 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id w75sm1913018pfc.135.2021.04.09.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 02:49:34 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:19:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [RESEND PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing
 base CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210409094932.hhh75drgyfmggy3v@vireshk-i7>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-04-21, 13:42, Pali Rohár wrote:
> From: Pali Rohár <pali.rohar@gmail.com>
> The armada-37xx-cpufreq driver changes base CPU speed from 1000 MHz to
> 800 MHz on EspressoBIN and Turris MOX. The commit message in patch 2/10
> explains why and how can this be discovered.

Applied. Thanks.

-- 
viresh
