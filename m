Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7F97176
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 07:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfHUFS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 01:18:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39157 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfHUFS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 01:18:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so627123pfn.6
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 22:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PKbkv7dCsXxL6099XgvMc1MnTHnKjsO7fUoQEHbudM=;
        b=KAfDhRxtR4GwDTAjSK9CxpevZU7g3KgK1uZ76h7TP+kS0w+eWjQ0SeKdZGKy8A509n
         iu2QKD4bjEcOqoKBQbauAM+GS0VjOoCBhTaMisId8bFTV0NFjmFuj74Ah2azeEFr7cmU
         3wdJb7chJ0ALkiU1/QfrUTMV4B9mef89UgDpUkah7wJQKr+aawUGIem0fSwi8V2/IXDw
         ki76yw78SykKIRhzhhpIog3o2HglARkdYAe0ujFYykN9l5BACIPPTPTILRd422be9pJ2
         D7FC+wJAvVzXfttFw/K0YxAGEU6xoxhqSFlvqyff6BpUQ/7NYjSqKJJiYy4yf0ZiZtlo
         XhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PKbkv7dCsXxL6099XgvMc1MnTHnKjsO7fUoQEHbudM=;
        b=YadTtNkmGl7PtcbLjg9leAZ4v3KFeOMhFegEu+DbnbygQcl7juxGOBMcQe0is7ePeM
         wmnAnQzTzN4STxL5deMXbYaWif8M8fdsytL2YfFH8eSLH9x06lhR5UsyzVdRqwa4AOOX
         xQxkegvNRFKfYJgIfh1wF/Qy+M77eeZcpSSlGJqBz42aI6aKuuRgfdBmMY8BwDWtJNzV
         yepFo6xLN1njL5wJDkQsUlbvG4fmczIbxdmFNTR0k0p5Pwygc36w1/ULrpatfsSnngIZ
         LVv04xLEJlXmgIKkQfglLf47QxIvmq59ahBg8B6RUPUA2z5Nm0tkc4e8yR3/Nsdgd7mb
         AUeA==
X-Gm-Message-State: APjAAAXnyxdjStgRFFzUa8j+xxvEZJpfgMg1UJGFP9+Ci2W4lJ5nR1rZ
        O3UGc0Z9ZdCq/WtnoHNT/+3vJA==
X-Google-Smtp-Source: APXvYqwK3tpphYbK/DaNP16+eBXl0afPM0c4m/Gk1KX28F1iKY9RB6O6htjPjQGJ7WPjXISaGCW1JA==
X-Received: by 2002:a17:90a:3847:: with SMTP id l7mr3375613pjf.99.1566364706853;
        Tue, 20 Aug 2019 22:18:26 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a16sm10356168pfo.33.2019.08.20.22.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 22:18:25 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:48:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/4] opp: Parse required-opp as dev_pm_qos_request
Message-ID: <20190821051822.pmfnoamqmpr42ldb@vireshk-i7>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
 <20190820065202.fet4ctxk4jku7ul2@vireshk-i7>
 <VI1PR04MB70237DE1719FB78C0427A436EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20190820092206.7cv3hfvitil2oyg3@vireshk-i7>
 <VI1PR04MB7023B5D1305A4A4BB9DF534FEEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023B5D1305A4A4BB9DF534FEEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-08-19, 15:48, Leonard Crestez wrote:
> The interconnect subsystem has additional capabilities (scaling along a 
> path) so I plan to use that instead. You can treat this series as a 
> "curiosity".

So I can just ignore it ;)

-- 
viresh
