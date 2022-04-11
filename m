Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58F24FB23A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiDKDUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 23:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbiDKDUA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 23:20:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408319031
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:17:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md4so5661600pjb.4
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dc09Mr/cRd+6iXXPVvE/h653BCcb5B6zFZqdYQ/noeA=;
        b=rzMBqfjbH13GjkNd1tBmKo8aloT92MH7r8uQkdBA376vb9LAQ0PHIrhQbqJkYk5siW
         qETuqVGhOBNPDjVkS55FB1P6dcHmapNUBDi9MJ5mE/YdpnNxwZ08J93t2/I31LjcdVWz
         xapIz9qLKpPnsXJ/On+QC8ZN8VL2nCh6e11OcpggkVKa+4009UNF5LxyjOoz3XRfUZYM
         4A983aYwACy9/4W3EUdP4eHBa/bg/ElgS7VMWJhew/XQDk+HaTDb39opLgiHsajsHNLF
         287aoOu1OEIuevlxZKmCEafIbE+fMwRYw42aARJMeYcKbqIPKX/9u1i7CNns2cBkuHI9
         F51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dc09Mr/cRd+6iXXPVvE/h653BCcb5B6zFZqdYQ/noeA=;
        b=PbTbAOHRtzGNo+7ASr9faidXg9jD749fGKekrKBKGJLCqcOZ20EkBIwQ5dHjnrSMCm
         4K+zsmHRZFqwBKwMUOuFVUjASH+WJzSZ72HZPYG7S7YyOGJ2UD3k6y77KfLNbdeP3j9B
         SkrrIcU3VOTkFMbkppLAqKFqvE/tLNbBV0HERnnqClpgYJ1GvQFd/W/KFPTli9N7O8Qt
         jP0pK7NdWYaeAAVbs2elA/30IWOSROzuw7J0SfhRfaR+K4G30l05sa64ETTCysW7o6my
         dRrD4AZICIlbTecxqKBXFyBjLhDIjmNPoIxx029Zh8KqTZyxFF8SvEB9OKk/bnSYLQD0
         63hw==
X-Gm-Message-State: AOAM531BcW3S9djVFzuYLIPmB2RfXzntarG2ISMpj5AiPav+mOUSfGPX
        PdBusUvxfu0CO5IEcLuz7XSZ2g==
X-Google-Smtp-Source: ABdhPJyZOTvJy00/iB836UyFTnhof3BtvKwJ4OR28/djCJgk7YRRuAcgMOQaw3eMSXkioq1mIoheSA==
X-Received: by 2002:a17:903:41c9:b0:158:52e6:343d with SMTP id u9-20020a17090341c900b0015852e6343dmr5509730ple.146.1649647067276;
        Sun, 10 Apr 2022 20:17:47 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm27214717pgc.91.2022.04.10.20.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:17:46 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:47:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 02/15] cpufreq: mediatek: Use module_init and add
 module_exit
Message-ID: <20220411031745.eumhltqjldryp6rb@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-3-rex-bc.chen@mediatek.com>
 <1e3338a6-d1db-6ae1-2cd2-d45a4babc844@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3338a6-d1db-6ae1-2cd2-d45a4babc844@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-04-22, 15:36, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > - Use module_init instead of device_initcall.
> > - Add a function for module_exit to unregister driver.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied. Thanks.

-- 
viresh
