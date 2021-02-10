Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514F33172D6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhBJWE6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 17:04:58 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43493 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhBJWE4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 17:04:56 -0500
Received: by mail-ot1-f44.google.com with SMTP id l23so3322003otn.10;
        Wed, 10 Feb 2021 14:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQ7cu9MfHe6aCf9OAL5eEgdmgHeTz7eoNLzlsX/XljQ=;
        b=sExBhcYum/qA9fLvw/H/yz/dLt+Ux5wIeOYP/CgSSmkkXxvvBVS3yhc9RV6ODBYLIe
         HNzY0+cl10x8sgrv9+TOUpA/xrk6WGhoNmnK0rhBcpPlO309IbRQ12rkr5Ne5Z0O734j
         1tGiJOE7qzX+g6eUKdhnpq3EZNQTOfMOl0CfSymOhxZNhPgnX4Vv1dRFWEpgj6i/mqT/
         ChMMY8VSKPmhPDyJWC8wgdjGgl8ynayQ00AflTLjYrx5c6qxzPT4CRMM0t1obawf8jgu
         H3fWz2cFFUw1XYVRD+IWW0Ioawjju6bRlKQjv5jxeomY9wNLBnvnhVKdolR55rK0ZvTM
         Bbow==
X-Gm-Message-State: AOAM533XjRn5aRhgNjFJxITaPvcE7pNmkpw+V8LbsjvyWUbUBeEb/21w
        E6sR6uShbtm58jWg08ylQw==
X-Google-Smtp-Source: ABdhPJwvaI4R3EJJTYNHhZsZgdSFd9OUgJOtk/ez6XnGX6c1KGRuS1jPfUij87XTNeV/TSeyjyldqw==
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr3529003ott.361.1612994655493;
        Wed, 10 Feb 2021 14:04:15 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e19sm631440otp.31.2021.02.10.14.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:04:14 -0800 (PST)
Received: (nullmailer pid 2878384 invoked by uid 1000);
        Wed, 10 Feb 2021 22:04:13 -0000
Date:   Wed, 10 Feb 2021 16:04:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Czerski <ma.czerski@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, sre@kernel.org
Subject: Re: [PATCH v2] power: reset: ltc2952: make trigger delay configurable
Message-ID: <20210210220413.GA2878331@robh.at.kernel.org>
References: <20210203214900.71677-1-ma.czerski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203214900.71677-1-ma.czerski@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 03 Feb 2021 22:49:00 +0100, Marek Czerski wrote:
> Make trigger delay configurable through device tree with
> trigger-delay-ms property.
> 
> Trigger delay is the time to wait before starting shutdown
> sequence after trigger line assertion.
> Trigger delay must take into account the OFFT time configured
> with the capacitor connected to OFFT pin of the LTC2952 chip.
> Basically, the higher the capacitance connected to OFFT pin,
> the larger trigger delay must be.
> 
> Signed-off-by: Marek Czerski <ma.czerski@gmail.com>
> ---
>  .../devicetree/bindings/power/reset/ltc2952-poweroff.txt  | 4 ++++
>  drivers/power/reset/ltc2952-poweroff.c                    | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
