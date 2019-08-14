Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F818CC4D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHNHIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 03:08:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34866 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfHNHIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 03:08:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so1071908plb.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=noA9l+lac2tFbODKUiemces22bFWF2XvyoUUU0oGh3Y=;
        b=azhHcHx6e2GPzq1qiXPKq9L0/FCy+3K5Ug+7kOM9qsxRMQvVJbQdk4B+sd9jPo1Wzm
         XUFDfEyv1O0gaQeTg8YERL8VT4vQRl44Lr844PzeDUfdP8nDuTFzs1GEGVxpExF3xus2
         JT3IsxKxLZ47NG/5vgeIDnHRAbxQfVqpGdkjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=noA9l+lac2tFbODKUiemces22bFWF2XvyoUUU0oGh3Y=;
        b=Pu2hoDnJWskT+K3uQ6Sok9KeXiB+bL3isCThvza3nkJxQC9B0sbodfj/yysaZymkSA
         D2A3MljaVuBqGmcLdlZZYrZ+9qA/BOjqvJJH+wZRjnXmV2FO6psDPm3k7SD9WXB4OFQm
         a9RwsdTQTN7XDbaRx/NQj0fxy+n6FILXLSdauvQIMgIlpeYYeYNo8XhElHpzpHMjkx1z
         OivpV/ZLWilA+geNQTRu5p2EK+yVyT8ceYL61/BRva7bfR09Dovrs4L0EsWXlgE2q7nH
         foExg8eqLTX85/ruEgXqE0L1wDxRmXmXwGk3561Q3Ux2iILaWQasCkGuxkefwmYjWKye
         /Mww==
X-Gm-Message-State: APjAAAXEvCEHeJXac3cME6sUnNHLB36NjXDM5WfU/h1rYyHEqTsOxEQ/
        7Mj2MCiJaJbR9As6U3SFeSrHUXJVgVs5yQ==
X-Google-Smtp-Source: APXvYqwhleD1WxLn9SQPb5TBxm/FmAKBDsfXxxHaV50lM2/VS0F8JJMyxYA9vP5R1sXtEGB5XR73nA==
X-Received: by 2002:a17:902:7612:: with SMTP id k18mr40585980pll.48.1565766520648;
        Wed, 14 Aug 2019 00:08:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e6sm14135669pfl.37.2019.08.14.00.08.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 00:08:40 -0700 (PDT)
Message-ID: <5d53b378.1c69fb81.31b2e.5077@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814063803.GY52127@atomide.com>
References: <20190814063803.GY52127@atomide.com>
Subject: Re: Regression in Linux next with show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Tony Lindgren <tony@atomide.com>, Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 00:08:39 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tony Lindgren (2019-08-13 23:38:03)
> Hi all,
>=20
> Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources stats
> in sysfs") has caused a regression in Linux next where I can now get
> some errors like this during the boot:
>=20
> kobject_add_internal failed for wakeup10 (error: -2 parent: usb)
>=20
> Any ideas why this might be happening? Maybe some deferred probe
> related issue?
>=20

Yeah! Take a look at this thread[1] and please test out patches I'm
throwing out there like a total cowboy(d).

[1] https://lkml.kernel.org/r/1565731976.8572.16.camel@lca.pw

