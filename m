Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE49618B214
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 12:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCSLIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 07:08:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45223 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSLIJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 07:08:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id m15so1071692pgv.12
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wET7jlYZA/4lYWuMPV+Ad+UExmNQxPrKP3xeSJ3g+Kw=;
        b=ySgV85Vy3ejQyPifI8tKJjqbe1gwDywC9nlpV1Mbm3nRFseO5pUgy8yyhQxCtwk/nt
         z8qNB8GDGqONIaYkv1jSadxZ7Ha/SehAakwLqbYy3ABjtn96W6l/PoY+r5T+8XVdXuf+
         aHGS2es72WncgUdpDJtZwrzIyxHBlMpQpp5vqZS2mqOdIHovL1dDiHx/Yup4i1+vD//U
         iKXeV9fV44li72p4GiYrbI80GKjxAlGxftzsN39E5YrParAraVzowhYqoAEEVegxHuWS
         rCTGLriRHveYnx84aMdrbXzwzy6QMhuOYUGOq8j4314e4lGImiGUIdQzY2G2aDnDYxLJ
         jnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wET7jlYZA/4lYWuMPV+Ad+UExmNQxPrKP3xeSJ3g+Kw=;
        b=cuD+MKBwS8DocB5+DzWGiHLApZ9yJM+ypkUiniRtPnxpm/Fjw4bzi+WY96hNQX0X8C
         FHjRPhw9L+hED06rRc16TyraJrrNEkSOruWPtZPzyMBB1LkERcsu9GKO9Rq7VVrA7aYx
         uHQLamiLBz25vnltA1EdbfCL2avICebJsmDbt0sxpF2bWRHmbiXqpo+BZMbskS7GJJXo
         2CbNywBWSyN0PKkO/e63Pl9c6WSk6vHFWW3rgrl0DdpTzm0EBpeOyy4AfT+giqUBu3iM
         62DFAan7CeVNsDNDtliIIXSykqNCyxEIUHt35SHp1pGPMIs3tI4ig1qZnthgJ1pFW0TI
         ltWw==
X-Gm-Message-State: ANhLgQ1D2zAmqSUanUJ8FjBbGMgcNP7q2repwvXwx18wec4bRlIdOyAP
        ZYmhP1zpoeA6SU48tTqU0D7CJw==
X-Google-Smtp-Source: ADFU+vtYvQQhg3OmZruUKxSIx/hPlBONPwH7mo3pcdX9ZDiCSLwANvh0o4aAcByJMnw3hG84WV24pQ==
X-Received: by 2002:a63:6ec7:: with SMTP id j190mr2739706pgc.356.1584616087501;
        Thu, 19 Mar 2020 04:08:07 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id i26sm2024923pfk.176.2020.03.19.04.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 04:08:06 -0700 (PDT)
Date:   Thu, 19 Mar 2020 16:38:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Message-ID: <20200319110805.glmuc2qvgcei3mon@vireshk-i7>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
 <20200318034243.o2metmggzuah6cqw@vireshk-i7>
 <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
 <ea4265f3f4b5a439d70d3c80bcc77b7f@codeaurora.org>
 <20200319102411.oivesngrk7gy7vtw@vireshk-i7>
 <78d92969-0219-d140-d788-d1b14e643e90@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d92969-0219-d140-d788-d1b14e643e90@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-03-20, 16:23, Rajendra Nayak wrote:
> 
> 
> On 3/19/2020 3:54 PM, Viresh Kumar wrote:
> I thought this series indeed is proposing to add that support in OPP core?
> a.k.a "[RFC v3 06/10] opp: Allow multiple opp_tables to be mapped to a single device"
> 
> These discussions are stalled for over 2 months now waiting on a response from Saravana.
> Viresh, whats the way forward here and how long do we plan on waiting for Saravanas response?

I agree and I am equally worried about it. So lets clear the air a bit
first. Can someone answer following :

- This series depends on the series from Saravana ? Right, so that
  needs to get merged/accepted first ?

- If yes, then what is the way forward as Saravana isn't responding
  right now ..

-- 
viresh
