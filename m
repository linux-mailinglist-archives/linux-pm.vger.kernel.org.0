Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E61EC04
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfEOKWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:22:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33514 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEOKWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 06:22:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so1149314pfk.0
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k8VFYCF5oSPyusd7YzU9vI+LHK0xPFnRUxwFyUrCXLA=;
        b=EQ9N1mnr6ZAQq91qE17FWFlHoZ4Bl9lxk2XZrVv8D4dzNfpeTPdY4yjSYCJ/BGq6Ad
         pRw0mXLb6lIhWlkK4SgDPmsHvY/IMBXn13WhNY1RgbOSH7JVAwUV17GOrEjX2BEYId2w
         8GMP4LMKrYY+0Fodr89ONmqevJq/47UWBeMeiTuFr5Dct+zv4FmkIRniK8RG1ug3sIXa
         wU1smfWprasCjvoeBliO9XQ9ZCFAhYkFdf1a0PqqhU1KnPZbQ4zB0T6PjItaIVqqXece
         7CQVEGFgRQVINfSdZyIZ7fiHoWStH62Sf3jk1mSvPbdl/2JSxYYUCxkt7W8b6Dt2Wspf
         3rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8VFYCF5oSPyusd7YzU9vI+LHK0xPFnRUxwFyUrCXLA=;
        b=SLLwI1UzAaWlVAA8tXOkHyO8gMqnIxN6lUjB1qap1c2+2101PY4WIaOC6djkeG4ps4
         zblxnIVodLkIqYfYUtC0C7ISPl0ykG7uBpEfzpc31Z3N4+4WidZxmusIlYFil7222FMu
         rzGdUWOi4KK7IJ4GvDf6cpPjRIHf48GrPb6HWwmHsjeS9M+el4rAfPqH56EjHqB98Tfm
         bStdV8iu3d9AT1xVTheWNZAQQ+Mu0xYupHvXXjNPr0lf+yb+/yIU8ZwvII7w3ATfzjxH
         Xi9mByMrM39KCHIt+gImVlv7uTqE3bM6lZZ0mJnTYUeUJXKsAp0ASrMaK0UUB3MLjkxu
         y5jg==
X-Gm-Message-State: APjAAAVhmyLCWCX2V5on+psBA37mUuKzNzE1bHSSrUZzxqRIaJouLzwz
        QcTj7YhjBzZlxX2HR5iHtix6hQ==
X-Google-Smtp-Source: APXvYqzzEK+huRkxpvvZM1btAPYw8+s8wBsDTQMcogYLW7ON2rMCIGENU0s1Jb8JEFb5VT952F7iiw==
X-Received: by 2002:a63:ee10:: with SMTP id e16mr37077998pgi.207.1557915723540;
        Wed, 15 May 2019 03:22:03 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id n13sm3827336pgh.6.2019.05.15.03.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:22:02 -0700 (PDT)
Date:   Wed, 15 May 2019 15:52:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Message-ID: <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-05-19, 12:16, Daniel Lezcano wrote:
> Viresh what do you think ?

I agree with your last suggestions. They do make sense.

-- 
viresh
