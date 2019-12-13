Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B801F11EE7B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2019 00:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfLMX1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 18:27:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35194 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLMX1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 18:27:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so1068765ote.2;
        Fri, 13 Dec 2019 15:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYp5sqcfkiifjsMp1o5uJlv1/2yExoosYWzgSPwTvDU=;
        b=MG6NmJueQ9BrjuZSQKM5uT7eb8YEXEHru3L2FCsctgotN7tteTy8gF0XwoM0O85jmI
         qBh2R2hCmy8pS3t1F3+LyCaanYUjyd/hHC8zrrfQft2ASozZBImGBvpi92x+ISdvU1FP
         sln1MxL1u3wlY+tSxdTHdMP/wNWFCUKCRobVQ7XRGU4ao2zxHCzTMsDs4swcGZBB+MT2
         gok4aSR/vlF6yXrLx8Xgqz9Z49NWX83m1cxBcSYhl0SuXZMEE+C/9bDe5JBVXIvS34y7
         i7iMHxMv1zDBzSMxZvEXtAQSugfQhpN5ZLEan69vfsPIFvkA2VfW34L4eSiZSMsUF0JC
         QNLQ==
X-Gm-Message-State: APjAAAWfVZkUAyoId5WUoMl3PdP7nkdSs/+r0w76OpQQL1gmMoG1GCcq
        9PtcUhbzeFovZXk/sjeLeg==
X-Google-Smtp-Source: APXvYqyGpF5zXlBMXF7YOJcUxQgwuziR4mu9FJxfXVqud5UO3DL8TXG5Inzr2scO0w0CkanlhM/Lxw==
X-Received: by 2002:a9d:768b:: with SMTP id j11mr17480041otl.116.1576279623911;
        Fri, 13 Dec 2019 15:27:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm3881140ota.61.2019.12.13.15.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:27:03 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:27:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH 2/2] dts: bindings: max17042_battery: add all of the
 compatible strings
Message-ID: <20191213232702.GA22495@bogus>
References: <20191202152520.27558-1-angus@akkea.ca>
 <20191202152520.27558-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202152520.27558-3-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  2 Dec 2019 08:25:20 -0700, "Angus Ainslie (Purism)" wrote:
> The bindings are missing documentation for some of the compatible
> strings.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../devicetree/bindings/power/supply/max17042_battery.txt   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
