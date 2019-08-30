Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6ACA39BA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2019 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfH3PB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 11:01:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44620 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfH3PB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2019 11:01:28 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so14530393iog.11
        for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+6AS1wxaosaOlU3Xtuxu0RL5HXDYhQrxbAdoPZ19vYs=;
        b=pSVl9bYd1QooTuZSyeNmhaOBRtjqTSbV2cgcRm38IMnu3KcnhSyrSo+3S3EKYdRY8t
         t/NyMeiG+PxGw2spFgAHwQHqxjbRJReIeH96l5s+Q7LD+Gs8rBCq9R5EdnHugT++kidy
         FLK4veATSyOFDVPTE4PCQXVI89ldXKA56Gdts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+6AS1wxaosaOlU3Xtuxu0RL5HXDYhQrxbAdoPZ19vYs=;
        b=QDWRBySh4H2ZlnVa5KICxSb4e+6kaLQGtZNCtwyojrikhZEMZw2s1ofy+L7/SpOOGH
         MH/q6sWkisR5MNhFfnzGxsuPCh624XjjdzN51ypQFrwTZDwJu/dQW9qNMmGkSylfIBGT
         N8AWKvqcu/K6YE3tdjvRVz9YNoDjueynCw+cO6Yd3pJ4M6W/iybp7N5jEskzGxZk7k/g
         WqdJXhq5EuksxNP/lc1uG5e5ZjufP4zLFJatDrbjH/Ccp9jFsHiGAmFOyJH547jk4as6
         TpYg5mAr/8kGIeAMZgApX1ytB+0yeEceGze7EBU2FRmQqJGtfI0vZ8I+3EuOPGON7Sxx
         /zZw==
X-Gm-Message-State: APjAAAV0rlBFTZOeQTWATtByBVu2H3u9k29A3jKnU9JjoMDzQ95dxWIB
        +xDTSX19itMkCdhiTn/11ldcsA==
X-Google-Smtp-Source: APXvYqxq+wRB1RyW9v8NRY8Y3CdZkE2gv/yw5RLu0LHoRhnGJPWY7GmO8OWIDwmh5HDMIuzUuwty6g==
X-Received: by 2002:a02:6a68:: with SMTP id m40mr16174861jaf.135.1567177287137;
        Fri, 30 Aug 2019 08:01:27 -0700 (PDT)
Received: from rocky ([2607:fea8:bea0:e11:9410:aa2:6ab7:15b])
        by smtp.gmail.com with ESMTPSA id c18sm4580330iod.19.2019.08.30.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:01:26 -0700 (PDT)
Message-ID: <13610f1bd1c248848611fbf2d46f351bed9ee7f0.camel@kepstin.ca>
Subject: Re: [RFC PATCH] tools/power turbostat: Fix caller parameter of
 get_tdp_amd()
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Pu Wen <puwen@hygon.cn>, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:01:16 -0400
In-Reply-To: <1567156956-29634-1-git-send-email-puwen@hygon.cn>
References: <1567156956-29634-1-git-send-email-puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-08-30 at 17:22 +0800, Pu Wen wrote:
> Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for
> AMD
> Fam 17h (Zen) RAPL") add a function get_tdp_amd(), the parameter is
> CPU
> family. But the rapl_probe_amd() function use wrong model parameter.
> Fix the wrong caller parameter of get_tdp_amd() to use family.

Whoops, good catch. Before, this code was only working because the
switch statement in get_tdp_amd() has a default case.

That said, this patch is effectively a no-op, since the get_tdp_amd()
function returns the value "250" no matter what argument is passed. The
only reason the function exists in the first place is that I thought
there might be a way to read the configured TDP from the CPU, but I
couldn't find any documentation on how to do that at the time.

Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>

-- 
Calvin Walton <calvin.walton@kepstin.ca>

