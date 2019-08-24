Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036CF9BC28
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2019 08:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfHXGIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Aug 2019 02:08:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41945 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Aug 2019 02:08:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so7060515pgg.8
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjXiDZcPg13ud8HX2Abc4oj6qqqpCxdm3e/7GRb5fno=;
        b=OJs2u3evPGUEzhVYCBg4N1J4qGKecQSQSRnTpf/fHA1wjWiK/Pe8aFyeh8ygwlfITL
         6iR0+/3QdmCP5gy3x9CvY8SkFE14poKKNcthhk/cJW7Y6g5eURfDE/6y2c2z47tfiuoZ
         Do6x5sgMaKkOj17oNmqVCFdWW/Pgk2xVHaRDQMbpXHGEl+iJpzQXExwajljy25nB4QHQ
         wTT4xWzatnN0ldf1bzSacLZaCZ7Xv3L+YuvXwVUC6u6zGJPCICrEMGzrGiDjYbiw8ndh
         JBhhBetTQN8K9G3iWTqKBl2jMJHyMb4ZIrRTmrODGQugN4jowrmheTIjw7KtQMGDjb2p
         xRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjXiDZcPg13ud8HX2Abc4oj6qqqpCxdm3e/7GRb5fno=;
        b=XbgjZTf3b1HvTx773fvCLYrYu2gDHZ8l6Bncoy88jyQUDOx08YoKxHUXg3xYDjgYyx
         J08nU1CmnBw/4VTndLIed2ukoRMrLAlW+908VoqJ0M+UQkLk4phevqRswgmfm4WL/ZGw
         dk+c/7ZcD3yoxlm2qr96YE3n6wBXvvSIRQjxTYuFp5xS8n2RH/ijDROtxQsOTzb8t7pJ
         CZn2Hmw9JaDdEuizbL4xfmcuHlCHvwSd2B4uNKACQ9Aqyiu77v1qPoaPG7g5VVQn8Z/i
         zn8zqiP3cnXiwx5voQ/95yol9jUSND5OWNhyNz0+J0CjiqU0N+ZldBPNUp+K9FaETVHo
         S7/g==
X-Gm-Message-State: APjAAAVgj23dd9IwjqIN5TEcg4k+UReQMpsALw+zp8pUaKQbxXM3AIgm
        7N8wCiMK1VcT6Sdp+630jg+jmDl8DRc=
X-Google-Smtp-Source: APXvYqzRd62Rjvd0P04+Cf0fLZBN+f2z09RpLAUz0XuudewgZKjL3cb+Mwo53cfMd+6nI6xSNbfAow==
X-Received: by 2002:a62:1941:: with SMTP id 62mr9344489pfz.188.1566626918459;
        Fri, 23 Aug 2019 23:08:38 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z6sm4247900pgk.18.2019.08.23.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:08:37 -0700 (PDT)
Date:   Fri, 23 Aug 2019 23:10:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
Subject: Re: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
Message-ID: <20190824061029.GT26807@tuxbook-pro>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 09 Aug 17:58 PDT 2019, Thara Gopinath wrote:

> The MX power domain in RPMH can be used to warm the
> the SoC in SDM845. To support this feature, introduce
> a RPMH power domain cooling device driver that can be
> plugged into the thermal framework.(The thermal framework
> itself requires further modifiction to support a warming
> device in place of a cooling device. Those extensions are
> not introduced in this patch series).
> 

This cooling device provides an interface to set a minimum state for a
power domain.  So while it's used for controlling the MX rail exposed by
the RPMh on some Qualcomm SoCs there's nothing Qualcomm/RPMh specific
with it.

Regards,
Bjorn
