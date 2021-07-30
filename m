Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5323DBE70
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhG3SfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhG3Sc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 14:32:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB72C06179F;
        Fri, 30 Jul 2021 11:30:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f12so13659301ljn.1;
        Fri, 30 Jul 2021 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLTRgWW1RC8wwF+L3PsHjCu3c3dwv6n19TzK0kS6YIw=;
        b=JmvXevrl2LOt3e2KuoIgrvxI8FsQnT84rnrdp2A3VztlrNyh5c1vsG7zuoFx3EF4xZ
         HRqsdZ+GzSORFsiy9NPqtgKmj2eK455Q4lfZVCpIcVPJmpp7OEeEl6VICGFARdeSDKhW
         zgGEbAV46pmmaaYP+3mxq3DhTrbKAlgcnyKwlfDeoJSgsAggumBFZqOXPHohkiWU+wpO
         0ldGo2nZEnT2SNgC03jOYgFKhy1LG9g7Cr5RpGoKVcSAq7x+YZVCYy/mhNWaqgQ6CeBe
         +g5ySNOu4n0abxLAj1l43W7Z0Bf8qTPvXPLrviji6cgXirp3QGB4BzQSZ9XsHuOng8qG
         4ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLTRgWW1RC8wwF+L3PsHjCu3c3dwv6n19TzK0kS6YIw=;
        b=K1Fqqd7ITDbUNWCAgJmZTbJhE+gt5Zqvpyj1DdQqnCCq+9xmaovgZS/Qv1dd2u+uQ9
         WQLr/YAFhX/v0gGpCWjbaf0+RUWpaHLOR2GxxNdWpVuWj55rBu38+uvLRipQtOejo0c/
         +7tQUUtTgnwOE6Un7TaBbp1i19W8YrPqDQ76A4Dv1xM24zQdz29L01vHORresbZrh6B7
         1p1rDAfZEKK9975vOal/BWLHk5PTC8EeNnMRJttSRLubWJZeD/93Jkcd+jY1viMZ13FM
         POTW8DNZKvhjrU+17VsHR/fRx5POsYxHO5m9viEKnYl9fOY904ML/Ir/T2EjIFEJGhm+
         Yzpg==
X-Gm-Message-State: AOAM533U5A5JD8EtxDiJFhuWUL90SQLMnx2U+Uwg14YJ+Hg8OrpN+MTR
        M2Kn6G1d2zL+wtt9aOjRo9Y=
X-Google-Smtp-Source: ABdhPJwFpji7ox8+1JGfmFGQYduc2n0jdrvImyTMPIbZQej5droNw1BHSHHnopCJYN4bgpXuToS5jg==
X-Received: by 2002:a05:651c:12c6:: with SMTP id 6mr2445246lje.173.1627669829233;
        Fri, 30 Jul 2021 11:30:29 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-114.dynamic.spd-mgts.ru. [94.29.39.114])
        by smtp.googlemail.com with ESMTPSA id h1sm210020lfk.187.2021.07.30.11.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 11:30:28 -0700 (PDT)
Subject: Re: [PATCH v5 00/12] Add OTG mode support to Tegra USB PHY, SMB347
 and Nexus 7
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20210717182134.30262-1-digetx@gmail.com>
 <ed3c2a5c-a916-2215-a767-5546fa8cd352@gmail.com>
Message-ID: <f612e599-42ee-f385-b198-bdab95ab890a@gmail.com>
Date:   Fri, 30 Jul 2021 21:30:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ed3c2a5c-a916-2215-a767-5546fa8cd352@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.07.2021 20:37, Dmitry Osipenko пишет:
> 17.07.2021 21:21, Dmitry Osipenko пишет:
> ...
>>   power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
>>   power: supply: smb347-charger: Utilize generic regmap caching
>>   power: supply: smb347-charger: Implement USB VBUS regulator
> 
> I noticed that charging doesn't work properly now, will fix it in v6.
> 

For the record, it wasn't enough to enable the regmap caching, we also
need to fill up the cache on init by specifying the num_reg_defaults_raw
parameter.

This uncovered another problem where the pin control "enable" bit was
unsettling because the default regmap values were initialized to zeros
and driver doesn't set the enable bit at all.
