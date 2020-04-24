Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3331B6B59
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 04:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgDXCaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 22:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDXCaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 22:30:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C6C09B044;
        Thu, 23 Apr 2020 19:30:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u10so6413706lfo.8;
        Thu, 23 Apr 2020 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWi/vih/fdORw5r13nsVhcqP42U/y5SZ8mxbRZKotUU=;
        b=iA7ZZmUVUGkgEzLCHwt06en1AYT6jF+LTthqBBF9qgERwzY3dnZmrm5i9h65YaAYEZ
         ngufClNYkXK5JURrY14EwntZ/mnb3L7+kN9CPHzBiuA8y9pEdUExgS44MNBaspT58jUf
         yRqmLB442NxQIeVi9YCctmUSPCY6vGfKYz1OvoIIa5Git3ANQFwXfYHlwEAKQ2vCpWgr
         HmJ/A0V8U/hU0VQvzNWOxmTcDjxV0LjSi1amZLySc1Ls5MOOJ3wsvMoGcdV3kGg3YwV9
         7R2HYwHJPJJMMRU+usLhuljFZx6iFJra+FWojrCJk5chGUp55GDGZ5yEX8puiraIobG1
         oW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWi/vih/fdORw5r13nsVhcqP42U/y5SZ8mxbRZKotUU=;
        b=NsUxKYw6ly3uJCZyYbJUYMy13R2srqOEBP6RpdsVTMcOl4fWzeFwtUSHFyu2/P6USk
         ZUsDko3nsKDkfqbU1VQ2ftmSTlikXJ0mNxwk6wNwOuoxbiO3Cf2Gf3JbEue+KPzSUw+q
         BqHAVBrrb+TT0rgrS3HukACGDPcMV7+eARqjdA7I9xBnCaICQRhtbMnZn3yPTfR2pYMX
         VVhHaqbMwRd0TLJm23ihWfHOmmN95bc52XIzeWL/3wYNDi0mtuw6XV1dF9DNxPJj7jVh
         BL22EzTmarBsrVW9dj/bqMjg743vWGbmhbg5SLQqEPNCSLYbrJJGgVcP5Rtp5p+EsYch
         a85g==
X-Gm-Message-State: AGi0PuYVfXfnigK6cSok5jrChPEBP+qTtcLt8w4NCsGvorTk0TXRrAOI
        YkJVxHEHMNOY82uF5OLqYHg9gA4GgKkYDlFVhjI=
X-Google-Smtp-Source: APiQypIbcKnB5kTwprnVNJIZcWAqoLug/rgqXZfGeEQRYeTrvFHSY2W4b0fXow22LMXqVZXBll4OCt9xuwb8wxJ583A=
X-Received: by 2002:a05:6512:54e:: with SMTP id h14mr4532469lfl.56.1587695407993;
 Thu, 23 Apr 2020 19:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <1587692801-12149-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587692801-12149-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Apr 2020 23:30:53 -0300
Message-ID: <CAOMZO5CmgxUggzZxpmeHT8Rh_Q9XXWvsMopOzq7NfVpkCsLVQA@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "rui.zhang" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Peng Fan <peng.fan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 23, 2020 at 10:55 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> i.MX8 SoCs DTS file needs system control macro definitions, so move them
> into dt-binding headfile, then include/linux/firmware/imx/types.h can be
> removed and those drivers using it should be changed accordingly.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

The From and Signed-off-by tags do not match.
