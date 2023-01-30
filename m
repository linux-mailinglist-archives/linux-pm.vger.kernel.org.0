Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB46813D0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jan 2023 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjA3Oxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Jan 2023 09:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjA3Oxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2023 09:53:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF4E29435
        for <linux-pm@vger.kernel.org>; Mon, 30 Jan 2023 06:53:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q8so8177758wmo.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Jan 2023 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySyb+9DeL5fJ0AqcUKPoABZaZNyjzAc//xSJ1ODmiuU=;
        b=JvdL81gB+V5vx6+HLY85U0rgTxjMwC0gvfTyDTmtTOCx8xh8EBdnu0pDspLJV0HZo3
         TCnPIi9tr+cFIbjmt9foLdiGqiM9fP2CawjIdBHp+Mhqe3vhIQkikf7wyGAl+/kubDrB
         ZESx1z6oMb2R3Z0IHUCuVtiIoCSFaJl4jhG2U6wsawPJc645tVzoKjA931jFvdwA0J18
         zVtKMlc4GvWnjskN2h5TwVqKB4/AtbB1SUeVT58cpfhGZbk3r/lswQQx78G9muEkvoCa
         KhviC8rbuAH1qpRjMjIcSDaIdqKE3UWLoWEMFZIhYiqAQc5a+8jgVzSKx8tBpnb2+OpH
         yjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySyb+9DeL5fJ0AqcUKPoABZaZNyjzAc//xSJ1ODmiuU=;
        b=rqGlfCQzLYt1X4Onx3ct00n1rhpTPVK2Uxlr6F47sZC4dN8tw7NlaybbuPzxLcGBt6
         vVoaE6apHnQQaymQ71v8DkDEndSpAV3pkELSKR9fe+pFEMfzTSUPeywnEmauieaqIWyZ
         AR8Q2vbhMXqKZnb2i3HEtqaV+cOqntoYIprmHLS3GD/AMwuqSpn2N7V09H6HSQTRGn2D
         0E85y3a6nVjcVXGjep48NzImaRu+LdDKWHyfTex1PVa2mLtuPCnBOXF/Ht1a7ai4H8IU
         QZHYL9bASiFI2dtA+6U4mVHMRgWsAg5WlPrNhFyEodu9Rn4+Q+502EdsgqFsckW6gg6v
         tEVA==
X-Gm-Message-State: AO0yUKUggZh+4eMTurlTgG7JvFdiafY+IB47xG3GCH4mnLuL+oHBB7pV
        vVuo7neve+Vg4i0KOi39lshApg==
X-Google-Smtp-Source: AK7set+7061y1dLtcQauJpeIRhWsE/OPFF1N/OwHvBvzWw6ZsTiAcij0rsvYYsbhx/z3ZiOR6whsfw==
X-Received: by 2002:a05:600c:5008:b0:3d9:f559:1f7e with SMTP id n8-20020a05600c500800b003d9f5591f7emr6446029wmr.20.1675090412131;
        Mon, 30 Jan 2023 06:53:32 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6b47000000b002bbed1388a5sm12167977wrw.15.2023.01.30.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:53:30 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:53:28 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>, djakov@kernel.org
Cc:     Mike Tipton <quic_mdtipton@quicinc.com>,
        Vivek Aknurwar <quic_viveka@quicinc.com>, djakov@kernel.org,
        quic_okukatla@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "abel >> Philipp Zabel" <p.zabel@pengutronix.de>,
        abelvesa@kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Message-ID: <Y9fZ6GUzWsCMXzba@linaro.org>
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
 <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
 <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
 <6dd7b0b0-f6fb-9de4-c365-d6cbfe04f2c0@quicinc.com>
 <742ff9cd-e7be-11b8-3805-5b60aba6b2f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742ff9cd-e7be-11b8-3805-5b60aba6b2f1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-01-23 22:58:49, Bryan O'Donoghue wrote:
> On 23/01/2023 20:37, Mike Tipton wrote:
> > 
> > This isn't actually changing it for all providers. Only for those that
> > define the get_bw() callback. Right now that's only qcom/msm8974 and
> > imx/imx. If get_bw() isn't defined, then icc_node_add() defaults to
> > INT_MAX. So, the logical behavior in that case is unchanged. Which means
> > this isn't even changing the behavior for rpmh yet, either.
> 
> Yes that adds up.
> 
> Looking at the commit for get_bw() for the 8974, I think this change would
> be OK with the intent of this commit
> 
> commit 9caf2d956cfa254c6d89c5f4d7b3f8235d75b28f
> Author: Georgi Djakov <georgi.djakov@linaro.org>
> Date:   Mon Nov 9 14:45:12 2020 +0200
> 
> @Abel what effect will skipping pre->aggregation() have on i.MX ?

I don't think there is any impact on i.MX platforms.

Peng, any input?

> 
> ---
> bod
