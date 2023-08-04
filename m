Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E31770227
	for <lists+linux-pm@lfdr.de>; Fri,  4 Aug 2023 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHDNrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Aug 2023 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjHDNrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2023 09:47:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E191BF0
        for <linux-pm@vger.kernel.org>; Fri,  4 Aug 2023 06:47:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so4209855e9.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Aug 2023 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691156861; x=1691761661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvbyZl7o3izzZQLp7Y0b9RIMj8QAxcAwWaunav84SDw=;
        b=FbpksK0asFziyiy+hK5v4TcQeeIaIR1NUXNvp0T8YwIEs6vbTIzOOo5KfzF6tSkBgO
         +OdFIboek/+rGTvwJN79ftPr13X8lXu6aHUbX1g+9fbgNpR9v7UIn2dpeeOfg+CW28K6
         IXUq18aclWGyg78WIg5kIQmrgzHvo//yDiiOnUyM5YsU0X/AYIQ6lbBi+7LZ0qtVEZZ/
         dpCzQLrCgHa7TCAU5XGJIgQQf/npJHeGH/CIU1W/Np8jwk5rYm8oNkXIQLm81oc/WcY9
         KTwJHeXxbI4QdnwLIUNXypwa12L+YonKHEMlefiMtlgb9HuxhmpKQzLV5h27Mk+Qarn3
         tY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156861; x=1691761661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvbyZl7o3izzZQLp7Y0b9RIMj8QAxcAwWaunav84SDw=;
        b=JQuNs9JosJ1N09WlUINfINWEoWiDUBDj2gLo33MCYuqmj5S2d7aSHHsMwShBn6j8Li
         neGNXeaj2yNqzyPxQVH4dTiBA93Rri5tmNMkmOG9IIdHtB4jZx8a14LUhzlQxCdu2TpD
         PQ2B86C4X/iPa3xvaiXET+FvCW+BdVMKw3n7lUWpS+YZzcRwB5MgJdgS/k2wF1wGmwNc
         fo1TKDGfkc3pGzW+HFMowxVZeB80oF1RmZYe9G0ezCSDZWK+gZcarqmYOIDP6LQQW5YO
         +lSeeoMJnPD5KMmG3oDtCsX0IbV+cxb1a2bjrs/I4I0xjzDhewsqaVr6rx+ri4f1FSKo
         87XA==
X-Gm-Message-State: AOJu0Yzs9tf2BTzC3UbW5MSi72hg/feJumKbkNnY0dx3WdNkkzTEHlI1
        NT6QnS7omAMGfVh4boztiMZkbA==
X-Google-Smtp-Source: AGHT+IGtmkXCcqnZuQaRYwvop1xV5GK+cjBPXEH1CvswNseUlrG58a4yXauQA15UyMe4/lX00LOAFQ==
X-Received: by 2002:a5d:4a4a:0:b0:317:6175:95fd with SMTP id v10-20020a5d4a4a000000b00317617595fdmr1319065wrs.43.1691156861110;
        Fri, 04 Aug 2023 06:47:41 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q14-20020adfcd8e000000b00314329f7d8asm2594246wrj.29.2023.08.04.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:47:40 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:47:39 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, maz@kernel.org,
        srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <ZM0Be8S8zII8wV4l@nanopsycho>
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fri, Aug 04, 2023 at 07:00:07AM CEST, claudiu.beznea@tuxon.dev wrote:
>Update MAINTAINERS entries with a valid email address as the Microchip
>one is no longer valid.
>
>Acked-by: Conor Dooley <conor.dooley@microchip.com>
>Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>---
>
>Changes in v2:
>- collected tags
>- extended the recipients list to include individual subsystem
>  maintainers and lists instead using only linux-kernel@vger.kernel.org
>  as suggested initially by get_maintainers.pl

Consider adding entry in .mailmap as well please.
