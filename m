Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20504401913
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbhIFJo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhIFJoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 05:44:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8BAC0613C1
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 02:43:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c6so3959525pjv.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9/JoqdqiEGw1zuw7XMiYKWfm9jX2kazYBZmS7xdP1/k=;
        b=WYPYOXSVHBptRJ0q9Gd1rc5ipBPKlx481Ahac7qF5CeFDcDQ2zjxcKbJwCRrjFpQA4
         hURmftGEPPPZNGOKyhyCUZvuAxvoFu33cooDNL0sJtGNAE3U83er9Yo+w+FA+xCLTaHp
         zdDpeLZIpgkTEJxbeUl9iSRWd0rTUZP8FUqiSSAUUA6OzGshEmCXKPWrS5XlqffUrHk6
         c5SwHWXP7iWD/nwZCyJM4vHpLhvsDwp7lVeG+xUOpQK3PyQxl9nbvpbddhkSXThLbJ9t
         IugRlfJRpSlP7nSdjEded1/CYqOnSt88zcdqT80QJRhYS1Qx0S22hjgqwZZ3zpqZwsXG
         QHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/JoqdqiEGw1zuw7XMiYKWfm9jX2kazYBZmS7xdP1/k=;
        b=HIbQ3k4BDmB4dp4wYjtv41duolMu1kEFmkNieFRPKHvsFDwP5XrPZoFGmhX3McgBaq
         ChkVyFvP/kQ3Rd9O2IVW7Yp98UObdJSL16yuwfdoHslgW2nRz4rmMAAlh6Ka4kubhmVQ
         QhEnK5rMqJTKDA/QuAsWhsUoDV3cNRg1l50vENAoHKww3MV+KsbKuHlhElgG7ntGm5Dk
         5AGkl9IUQt7agG9qEymLZOgQuZm8bMqJr7Form2JZHklEnZZ5SF6FPlujlPDbuMamAmK
         GcRcyaDbDW+kHgRcf+8Oam/ymM4lDJ1k09rQP7IRJducBvi0Jv6ZvZQWUSuIjVn6W2xd
         8J7A==
X-Gm-Message-State: AOAM531OLGmiIOmw1LxENI+sdxept9LtLvpg27WTWFlsbYBK2hkO3UPE
        u0/ih7UBu3ltrRx+hcsB0gHBQA==
X-Google-Smtp-Source: ABdhPJwNLy/dXfiYyQnEloJsYlqUGd8CyWCxWl/Kjp+bv4L5M2+jjwqp/8iOZhRvgKnezUoJoGhmkg==
X-Received: by 2002:a17:902:e34b:b0:134:66bd:f241 with SMTP id p11-20020a170902e34b00b0013466bdf241mr9959608plc.27.1630921394459;
        Mon, 06 Sep 2021 02:43:14 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id nh21sm6955135pjb.34.2021.09.06.02.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:43:12 -0700 (PDT)
Date:   Mon, 6 Sep 2021 15:13:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v15 2/3] cpufreq: Add of_perf_domain_get_sharing_cpumask
Message-ID: <20210906094309.rcacbme27zpvdd4a@vireshk-i7>
References: <1630658364-6192-1-git-send-email-hector.yuan@mediatek.com>
 <1630658364-6192-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630658364-6192-3-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-21, 16:39, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add of_perf_domain_get_sharing_cpumask function to group cpu
> to specific performance domain.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  include/linux/cpufreq.h |   46 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)

To speed things up, I have applied this with following changes. Please
test my branch and see if something breaks:

https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/arm/linux-next

-- 
viresh

-------------------------8<-------------------------
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9eb1fa17a8a4..acd3ee5b8b0a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1006,37 +1006,49 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
        return count;
 }

-static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
-                                                    const char *cell_name, struct cpumask *cpumask)
+static inline int parse_perf_domain(int cpu, const char *list_name,
+                                   const char *cell_name)
 {
        struct device_node *cpu_np;
        struct of_phandle_args args;
+       int ret;
+
+       cpu_np = of_cpu_device_node_get(cpu);
+       if (!cpu_np)
+               return -ENODEV;
+
+       ret = of_parse_phandle_with_args(cpu_np, list_name, cell_name, 0,
+                                        &args);
+       if (ret < 0)
+               return ret;
+
+       of_node_put(cpu_np);
+
+       return args.args[0];
+}
+
+static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
+                                                    const char *cell_name, struct cpumask *cpumask)
+{
        int target_idx;
        int cpu, ret;

-       cpu_np = of_cpu_device_node_get(pcpu);
-       of_parse_phandle_with_args(cpu_np, list_name,
-                                  cell_name, 0, &args);
-       of_node_put(cpu_np);
-       target_idx = args.args[0];
+       ret = parse_perf_domain(pcpu, list_name, cell_name);
+       if (ret < 0)
+               return ret;
+
+       target_idx = ret;
+       cpumask_set_cpu(pcpu, cpumask);

        for_each_possible_cpu(cpu) {
                if (cpu == pcpu)
                        continue;

-               cpu_np = of_cpu_device_node_get(cpu);
-               if (!cpu_np)
-                       continue;
-
-               ret = of_parse_phandle_with_args(cpu_np, list_name,
-                                                cell_name, 0,
-                                                &args);
-
-               of_node_put(cpu_np);
+               ret = parse_perf_domain(pcpu, list_name, cell_name);
                if (ret < 0)
                        continue;

-               if (target_idx == args.args[0])
+               if (target_idx == ret)
                        cpumask_set_cpu(cpu, cpumask);
        }

