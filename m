Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A366D566
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 05:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjAQEkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 23:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjAQEkq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 23:40:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CC22DE1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 20:40:45 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r21so248200plg.13
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 20:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiaqS8eJIivQZZrHcACmI6CZn2DiPVnRAGrMHmaEX8Y=;
        b=DRN0k9RGnGV5grqDEIZfgyguel4CF4Ms6quLkNW9iNNOf1DKyVv9XF6WyaIUVfUtQZ
         KZ3GDDw+79hfTRCp8CYvDaN1LJd2VEJP/ottbsyP6M2Ki9xwWqS97jvOqbJcvlaDc4mF
         769SX7AoZs4ojtMKl5XdktuGoncLdsbp82+aLfKvUfL9YGawA5J7MC/Pzs6yHS01Px6A
         zKJuicYusEEdw/05/3iLXq1e+nOYOmRQ3srbKLEhBUPS8QrfrYGWxwOotKHorVfs/a0Q
         BvZKsCwR7S2fpsnCPdIBF97OrfXysZW3HSFknS4pfkQzXeYfgbPVfwYMEEcMS8KEafwh
         btiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiaqS8eJIivQZZrHcACmI6CZn2DiPVnRAGrMHmaEX8Y=;
        b=Pn4HCWpbDoIGcq6uQVH8ZmbLFtVQ245mWAPmf6/UB9lewBPtk0j2rVFajT+vgHNsP+
         Sm7fDTa9Gjx3d3bw0WrmJbr7uCQQ2QBs1sqKnREKziJg1BdKz5i7a/FaxZlDFDvrCCuR
         /dRgJdo8URXFVJ8P77uq8fxZJWBAA1pH7NX4EC/EwSzwruJeqAuT+2ZdC6gMwJj7L3ia
         h1pZudE0In8z38SnQfOC7e5k61fGKy3A9G2N5HlG9TW8n03qigPur7mwlT/i8bbRVoCq
         ZlSKb9gssfRyaZW5mrBDsfcFBkVJ+TrGTLN0cix8qeY05iIQt6udLzxxSbat6DbysmXU
         qGZg==
X-Gm-Message-State: AFqh2kp4bVBSmBs1pepfwrnMFXMTM/Zeglu/00wxNFSMEE8b60gE5tpN
        i5J0+Q2bK/wSuz2Skd/mdCHFJQ==
X-Google-Smtp-Source: AMrXdXtyjJQGf+6xFs4tE1cm1fp/LfTMtSviMzgJP5liCaKi8MGt73vw2md0WXj64q43aGtPbH+ZOg==
X-Received: by 2002:a05:6a20:3d83:b0:ac:98db:d4cb with SMTP id s3-20020a056a203d8300b000ac98dbd4cbmr2252750pzi.41.1673930444711;
        Mon, 16 Jan 2023 20:40:44 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id i22-20020a63e456000000b004a4dc6aeae3sm16583366pgk.74.2023.01.16.20.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 20:40:44 -0800 (PST)
Date:   Tue, 17 Jan 2023 10:10:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Message-ID: <20230117044041.4oforjgg4x4c2iok@vireshk-i7>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
 <45cf54c0-2a77-c06a-b81a-823514f7c5e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45cf54c0-2a77-c06a-b81a-823514f7c5e1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-01-23, 12:22, Caleb Connolly wrote:
> I'm not 100% clear on the benefits/drawbacks to the different
> approaches, am I right in thinking the improvement here (compared to my
> patch) is in giving each error condition it's own path so there isn't
> any ambiguity?

There was still confusion about what should be called when, like
device_put() can't be called with just dev_set_name(), etc. Also I
made a mistake which Yang mentioned,

I have proposed a different way of fixing this all for once, lets see
how that goes.

-- 
viresh
