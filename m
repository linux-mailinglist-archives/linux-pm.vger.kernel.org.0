Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6E0333BE0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 13:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCJL72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJL66 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:58:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36677C06174A
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:58:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so23035390wrz.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rUrQmd7md0y2mnEITUOs43I8wXuqCA0VPutH0poYyPg=;
        b=IYUUsfTVeuYlEeAwGRPh1HPNnomx5Z0yp13XyvsNjHS+Pc6q0FmOjKM8llQpeetgzg
         FRrUHxjIyXZ3Y+9GC7buCMjxeolAtA9Ds2+oLD9J7vM7kkTAjH9nENTDnOFWL3haXL5j
         Gff97KCjB6/5XXo/rH74rP7t7f0xqoEKbxEUOhVsp6T5K/vW9kGm8/9KrwB/kOr6AWIg
         vXs9VnkJIr3DUptCXoLLJhYJleYIXGXlO2KbXpi3AA5MaYlpKUXxH348fr0CMd4caUjp
         Gs84xPkO0kag1iOqV7T56LyImDWmjMcBjg/XtkMNZVyMgya5woXQCn75sFXyZ/3zevZI
         +W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rUrQmd7md0y2mnEITUOs43I8wXuqCA0VPutH0poYyPg=;
        b=ehLrkBEJ6eV0Rirn3YBA2j3t28otqPbdDVkg7dUYT/FJRkLTeJitj5Xvs3y2mNLU4Y
         7Vv4DendS7hjXP9nvBlvUwkpwhsqxd1ORSWu3E0VJtm/Rhpql82lxGeDEzpNDOam8lCg
         2uI5j8z5GUalg/kt1dqVrUpucB+o9GKaSfkgQ3JR0nlAacLZUzQRK4a5veQ8qaqZRoZj
         cUWJNXiffRFaIa0elXo5bMzBmA7+9VXpE304LXIzbYsxOczwGp9Cf6a0jhjVZHfNbRds
         NYHG5+y+tKqtABnfUfTShikD7O6uZKMlaGPNqRu12g4lvrJwnPypW2/LHP8vS3Yyrqu9
         yKDA==
X-Gm-Message-State: AOAM5303lrOBH/ywd0f5sCsIkjiAsQQqJk5UDU32jx629G1NPsVPeDsu
        4A6YrCZjOB7naD/tjA8XZHF9lg==
X-Google-Smtp-Source: ABdhPJzNli5fgiwryc5GMOwljLQKLTlgS+lC6xLKe1ECaur6dGz4EvU5DM7NZfYF7QOq+Dh564b4Vg==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr3210372wrm.291.1615377536711;
        Wed, 10 Mar 2021 03:58:56 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id m17sm29632508wrx.92.2021.03.10.03.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 03:58:56 -0800 (PST)
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Add support for up to five
 TSC nodes
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ba60c08e-689b-849d-c232-26aad08ca036@linaro.org>
Date:   Wed, 10 Mar 2021 12:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/03/2021 17:24, Niklas Söderlund wrote:
> Add support for up to five TSC nodes. The new THCODE values are taken
> from the example in the datasheet.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
