Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54E34AE4A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 00:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfFRWy3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 18:54:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43083 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfFRWy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 18:54:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so8477212pfg.10
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 15:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n35MhVkr6H+P8RbX9QmFmc4cFxEYiEzQlK/5dRl1R2c=;
        b=jSXiDkOhmC5K8D+V0W/2jmD0yc8A3p0h3wtgza5X2UBSGAkyhUgswFPXx5gKW4HW1U
         NzgRzGAC5/wCIQoQ5/C79ZESyiIqQutuavI0XWkIOQ5MdEjUDr/yrYApH6SeEVsZmUfL
         as2JgaZ+L3SzeRjMbcwRXqSRT9y3RzLIMvTTJDPfclbmJDJF4USZq0PYazaG12+crD6f
         uFJ0g7/PRTwkQw8ndzYZAphxjHE4iRYVBaZZA723ITmTAFg/agh+R2s/YqxCXTk91T+g
         kvT0rFJ3JvYOiiHBBGiT2A+hu7/CYtXL4uqaWTn/H9ReyoIrdtKmsB2W/kNi5aO/uPqQ
         xyyA==
X-Gm-Message-State: APjAAAU8GazNTWEVIAHlDAd6uPaG88NTSLwQJmOIyFJKUwuDVFSyIENC
        uRBWJftDN8KXNlXTGuUaLJV70Oew1to=
X-Google-Smtp-Source: APXvYqy4/1vnHL54lmljzZ72gCeOuPOBaploNdQkv4L0TH7vPhLV/zx7eB7JEBYzeX83sXKtLNtcEA==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr25084866pfi.139.1560898468398;
        Tue, 18 Jun 2019 15:54:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m13sm3088995pjq.16.2019.06.18.15.54.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 15:54:27 -0700 (PDT)
Subject: Re: [PATCH] PM: Show how long dpm_suspend_start() and
 dpm_suspend_end() take
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
References: <20190605161237.176983-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0b367c17-11a9-3f37-4359-8c15703e8828@acm.org>
Date:   Tue, 18 Jun 2019 15:54:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605161237.176983-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/5/19 9:12 AM, Bart Van Assche wrote:
> When debugging device driver power management code it is convenient to
> know how much time is spent in the "suspend start" and "suspend end"
> phases. Hence log the time spent in these phases.

Ping?


