Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1220F2096D
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfEPOXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 10:23:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35414 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPOXm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 10:23:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so234365pgc.2
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jrk+rpw8J8CTsHQ9cBEqb7CiKn9QorTOHcoV2OsZp1c=;
        b=Aslk4mGoDz9R6CtfPxhVAJtoT/vFRymvtpoC087MDA4WZmiXrQcxlGHfwraASUXaGt
         Uo7Ksvx3PYAfBaD+q0+/5NvquE9c0oiPc/hCQX0HxAP3WwMxcVIN0H75y5dI708tKEU3
         wAdpQhUZwEF1gIT+bZKbaw00uRhalfbvYy+7p9DMoGlwA6Gh1FqKFn1IZZrKLJgzY6QS
         jn3BD8W7gvsgbNTrkuM1ReMi7Se2x9bMKAHfnWLQ9SlgJN4KyQPohy0o7LMpyMOoF3BN
         mxJPNAoH+JMRJyVrsBotjH416Z0bLEEcsEZWA+WbONcPd3/kkSjMKp0mhOHd+qILERpC
         W85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jrk+rpw8J8CTsHQ9cBEqb7CiKn9QorTOHcoV2OsZp1c=;
        b=s2PTN7PD4mUmF8WnLxBEXpTkDmjKeFouzB9bUfmwRkQ+K8NybkTYFxG6UkLRCGuScY
         KUvhGT7ETER1Nr4b6rPE1WjbruNlLAXLT80lg39osrie1I3sDbjwG7EH8auCyQSSHQPu
         6WfsTVtaapMe6q6cIlv0zKFY7Eep6CPHooR3f2+FthFOETcyNUI8GZkfsVu6C7fUHRtN
         EFzUIfYP51Ig5PyutAP8jbpkjqI5Ty5CPvc0E7CaRKtGAx2uYrAmvqWKqAf1CSX4Jixy
         1Juvp6ZrPRTSIqeZE4xjfUWyODuCm+7iroRx1uciZMVlIgSikviE4K+uclFm7ct5ZJMg
         WKKQ==
X-Gm-Message-State: APjAAAXd8cweGQZYk/724TJjcM0slA0MmrE/hJhlzNr34c8QKqCseidz
        /jC01E4ZpXoxPRZ46SZXnWU=
X-Google-Smtp-Source: APXvYqwDAcFXdXnj1KLwN2Q/551ng9KWAxjNfcCJzigXn+gFyg4EtYIZF0kgOgBWLvaDwr5Kz9TIrA==
X-Received: by 2002:aa7:8e04:: with SMTP id c4mr53893146pfr.48.1558016621914;
        Thu, 16 May 2019 07:23:41 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j22sm7140939pfn.121.2019.05.16.07.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:23:41 -0700 (PDT)
Date:   Thu, 16 May 2019 23:23:38 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
Message-ID: <20190516142337.GD24001@minwooim-desktop>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Akinobu,

Great feature here, I think.

> -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> -		      void *buffer, size_t buflen, u32 *result)
> +static int nvme_features(struct nvme_ctrl *dev, u8 opcode, unsigned int fid,
> +			 unsigned int dword11, void *buffer, size_t buflen,
> +			 u32 *result)
>  {
>  	struct nvme_command c;
>  	union nvme_result res;
>  	int ret;
>  
>  	memset(&c, 0, sizeof(c));
> -	c.features.opcode = nvme_admin_set_features;
> +	c.features.opcode = opcode;
>  	c.features.fid = cpu_to_le32(fid);
>  	c.features.dword11 = cpu_to_le32(dword11);
>  
> @@ -1132,6 +1133,22 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
>  	return ret;
>  }
>  
> +static int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
> +			     unsigned int dword11, void *buffer, size_t buflen,
> +			     u32 *result)
> +{
> +	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer,
> +			     buflen, result);
> +}
> +
> +static int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
> +			     unsigned int dword11, void *buffer, size_t buflen,
> +			     u32 *result)
> +{
> +	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
> +			     buflen, result);
> +}
> +

I think it's okay to separate this part from this patch. :)
(I guess I have seen this kind of patch from Keith, though)
