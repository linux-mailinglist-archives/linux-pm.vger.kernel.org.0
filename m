Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937D43FCC00
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbhHaRED (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhHaREC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 13:04:02 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5645C061760
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 10:03:06 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so5882231ooh.7
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aquqJwbc9m/hIVCd01TlOuCXbAUHlFJOz/03vmUb8IM=;
        b=q5jjzmupuZysdq6pWM6sahYpgGRYgqndWyW/wAc+WhHHcvPtSPx1jDAU0woWnKbRbo
         tn/icMFl7O5TPVcbFWiyHWfHBfvH5q4M81Eye4+TLIsH/xh7sS1GZCXpszVjli5RBp7t
         qmxrNg7JaX8/jUCQ5qmckF4xKx4F33oh3CEKEfs8y9TcaZBc93oUfwmnVbwoNriqOyBO
         R9cYqvxZZbqb45UeyIa/tIfRHVBkkfpDqNdXKGaCkcrWV4ntPwL+rWnRq9jw/awNpe5d
         Kr7ft9qBkhKzqN+TUudBVrTf8xbZcd/tYx7zs2WSramLm+f3npGOdIeZzeF7mA5ujJjR
         s8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aquqJwbc9m/hIVCd01TlOuCXbAUHlFJOz/03vmUb8IM=;
        b=rTfUwc/NvaZKedEN46W5AVf5sINhUzZez4bvQe2xIUZLTeI9UVrPyDl9RpBpb4c2EO
         OANuBPxyvW0X0CzSb+TkKBHiN/hxDDtiKfRi0txhgzuiLJPpkSk6CUnU0U09V6zGD/47
         U4beiE8grTX8njN7Fk8pFxJ0aQ5QSarp5DhoHRLVi1lxESiJwu2UJ92xJr6t3tdH2X1p
         qn3qEzSHTziaFW/Xvu1cNlXAJWtb5mNOm/+UUqD+/BVG4EKnw6z9D6qY3nlbKn247hK9
         NLJZre/Rxg4tc8m+PVcGqcNRT372TWELDkmUeuu7+JrHq1jpxiW9UQ9yNzTMHTXKEDpS
         M3cw==
X-Gm-Message-State: AOAM530ZIOcSDL87lb6eW5dj6bDzzhn1hGpLhzniKaf/flqbKm1XRblk
        ZXLGoUSNKX+Vrf41sMO2puI3Hw==
X-Google-Smtp-Source: ABdhPJxKKFdY8MvkADZc3EpXGvVWUIRpCwdjGVe7w41nCD/MZyO774PBzlWQ8ANv/3d0FU5rFERitw==
X-Received: by 2002:a4a:df43:: with SMTP id j3mr15210793oou.37.1630429386025;
        Tue, 31 Aug 2021 10:03:06 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y138sm3647410oie.22.2021.08.31.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:03:05 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:04:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
Message-ID: <YS5hDq+xblntYbh0@ripper>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
 <YS5LDb4KDFx/dRnM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5LDb4KDFx/dRnM@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 31 Aug 08:30 PDT 2021, Matthias Kaehlcke wrote:

> On Thu, Jul 29, 2021 at 11:34:44PM +0530, Sibi Sankar wrote:
> > Fixup the register regions used by the cpufreq node on SC7280 SoC to
> > support per core L3 DCVS.
> > 
> > Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> This patch landed in the Bjorn's tree, however the corresponding driver
> change ("cpufreq: qcom: Re-arrange register offsets to support per core
> L3 DCVS" / https://patchwork.kernel.org/project/linux-arm-msm/patch/1627581885-32165-3-git-send-email-sibis@codeaurora.org/)
> did not land in any maintainer tree yet AFAIK. IIUC the DT change alone
> breaks cpufreq since the changed register regions require the changed
> offset in the cpufreq driver.
> 

Thanks for the note Matthias, it must have slipped by as I scraped the
inbox for things that looked ready.

I'm actually not in favor of splitting these memory blocks in DT to
facilitate the Linux implementation of splitting that in multiple
drivers...

But I've not been following up on that discussion.

Regards,
Bjorn

> Sibi, please confirm or clarify that my concern is unwarranted.
