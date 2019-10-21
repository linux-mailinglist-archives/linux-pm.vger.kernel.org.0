Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13410DE1FF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJUCP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:15:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37148 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfJUCP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:15:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so7396990pfo.4
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7Q4LZifGL7VHvZw/Cjerl4FYJxwkVtMy+33DYa6tmU=;
        b=jQVWXTnbLFCmmP1dE9F9kegEBWgp/9HIGqCxhdYO10WPo85dD8zOiecS2ZMt0ynGYS
         3PmBtO5nvq49dWEJOlBWkq5C3jN1/3o93F547Cg6ta5nDjIzic6Hr95jAA3TYfmi5p4E
         +apQjSARDiGALO4Ktig2vugQ5BTCoZmDXA2gU6qTmwzAveZKBPZzsXc/l1sS97zqQ5j8
         Yy9R1JEe57xqjY7ekFZbdWaeRLP0rSDXKRZnX//XcGQArgFzCM8GyLVDPzcRF2sndFWP
         tGX2ifR1s1zeBVGNGoTPYIar/wucytN+ZI1relNUQr+xDWeCAyZFKtSTresLaDVVoCMd
         3RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7Q4LZifGL7VHvZw/Cjerl4FYJxwkVtMy+33DYa6tmU=;
        b=D5zpFyjCav+2vsbr2M3BTIZnoSv1Og9ObRlxmkuDj0AD9MdDlJvbDei9hIooRvBdsd
         okrgKpnjVfMyHJnJuaLpvC+fcfe4efNRzl+0vps1a3wZAjR0cpk3M5fLuHj2098AcvPk
         cQtW94piNDcnk5ErxV6PumsvKRNV+Kjns5F894eLVkt/JDqglpA7tRlnEU36L6xyvJ79
         nkjPdWUAgS5NSIiDCzhTdtFI6URVT1aIiWhXks9fyd6sq0ZvHFmqEVH7p6f1uquUrq3d
         HOvy5mJrZabIpCChPMgRnaFHKsZ9erylFeY/nEcOvr0ulQpaW5RaWiOdwQ0Yh06dsFbh
         do2w==
X-Gm-Message-State: APjAAAXIcdmypoQOKhA+fG8MycrCeNtOq5vaYk408lztILYFtqvOAWGn
        pxCk6IfiFj0Ga2gx/1yer4m8OPw7xA4=
X-Google-Smtp-Source: APXvYqzelopchHc5kd7KDiVDWvBUvBXKfv2ziRjbolBOmcK/p4njnjkRPIHp6rGh8Xa6eQ1PQTSMTw==
X-Received: by 2002:a17:90a:fb85:: with SMTP id cp5mr25789957pjb.19.1571624155496;
        Sun, 20 Oct 2019 19:15:55 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id p189sm14070465pfp.163.2019.10.20.19.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:15:53 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:45:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus>
 <4881906.zjS51fuFuv@kreacher>
 <20191018110632.GB25540@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018110632.GB25540@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 12:06, Sudeep Holla wrote:
> Callstack is:
> 
> (cpufreq_notifier_max)
> (notifier_call_chain)
> (blocking_notifier_call_chain)
> (pm_qos_update_target)
> (freq_qos_apply)
> (freq_qos_remove_request)
> (cpufreq_policy_free)
> (subsys_interface_unregister)
> (cpufreq_unregister_driver)

@sudeep: I see that the patch is merged now, but as I said earlier the
reasoning isn't clear yet. Please don't stop working on this and lets
clean this once and for all.

What patches were you testing this with? My buggy patches or Rafael's
patches as well ? At least with my patches, this can happen due to the
other bug where the notifier doesn't get removed (as I said earlier),
but once that bug isn't there then this shouldn't happen, else we have
another bug in pipeline somewhere and should find it.

-- 
viresh
